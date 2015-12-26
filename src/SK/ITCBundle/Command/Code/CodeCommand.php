<?php

/**
 * SK ITCBundle Command Abstract
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code;

use Symfony\Component\Console\Command\Command;
use SK\ITCBundle\Command\AbstractCommand;
use Symfony\Component\Console\Input\InputArgument;
use Zend\Code\Reflection\FileReflection;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Finder\Finder;
use Symfony\Component\Console\Input\InputOption;
use TokenReflection\Broker;
use TokenReflection\ReflectionFile;
use TokenReflection\ReflectionClass;
use TokenReflection\Broker\Backend;
use TokenReflection\ReflectionMethod;
use Assetic\Exception\Exception;
use Monolog\Logger;
use SK\ITCBundle\Code\Reflection\Reflection;

abstract class CodeCommand extends AbstractCommand
{

	/**
	 * SK ITCBundle Command Code Generator Class Reflection
	 *
	 * @var ReflectionClass[]
	 */
	protected $classReflections;

	/**
	 * SK ITCBundle Command Code Generator Operations Reflection
	 *
	 * @var ReflectionMethod[]
	 */
	protected $operationsReflections;

	/**
	 * SK ITCBundle Command Code Generator Finder
	 *
	 * @var Finder[]
	 */
	protected $finders = array();

	/**
	 * SK ITCBundle Command Code Generator Finder
	 *
	 * @var ReflectionFile[]
	 */
	protected $fileRelections;

	/**
	 * SK ITCBundle Command Code Generator Broker
	 *
	 * @var Broker
	 */
	protected $broker;

	/**
	 *
	 * @var Reflection $reflection
	 */
	protected $reflection;

	/**
	 * Constructs SK ITCBundle Abstract Command
	 *
	 * @param string $name
	 *        	SK ITCBundle Abstract Command Name
	 * @param string $description
	 *        	SK ITCBundle Abstract Command Description
	 * @param Logger $logger
	 *        	SK ITCBundle Abstract Command Logger
	 * @param Reflection $reflection
	 *        	SK ITCBundle Abstract Command Reflection
	 */
	public function __construct(
		$name,
		$description,
		Logger $logger,
		Reflection $reflection )
	{

		parent::__construct( $name, $description, $logger );
		$this->setReflection( $reflection );

	}

	/**
	 * Gets SK ITCBundle Command Code Generator Broker
	 *
	 * @return \TokenReflection\Broker
	 */
	public function getBroker()
	{

		if( null === $this->broker )
		{
			$backend = new Broker\Backend\Memory();
			$broker = new Broker( $backend );

			$this->setBroker( $broker );
		}
		return $this->broker;

	}

	/**
	 * Gets SK ITCBundle Command Code Generator Finder
	 *
	 * @return \Symfony\Component\Finder\Finder
	 */
	public function getFinder(
		$name = null )
	{

		if( null == $name )
		{
			$name = 0;
		}

		if( array_key_exists( $name, $this->finders ) )
		{
			return $this->finders[ $name ];
		}
		else
		{
			$finder = new Finder();

			$src = $this->getInput()
				->getArgument( "src" );

			foreach( $src as $source )
			{
				try
				{
					if( ! file_exists( $source ) )
					{
						$this->writeNotice( sprintf( "Finder Source '%s' not Exists.", $source ), OutputInterface::VERBOSITY_VERBOSE );
					}

					if( is_dir( $source ) )
					{
						$finder->in( $source );
						$this->writeInfo( sprintf( "Finder Adding directory '%s'.", $source ), OutputInterface::VERBOSITY_VERY_VERBOSE );
					}

					if( is_file( $source ) )
					{
						$finder->append( array(
							$source
						) );

						$this->writeInfo( sprintf( "Finder Adding file '%s'.", $source ), OutputInterface::VERBOSITY_VERY_VERBOSE );
					}
				}
				catch( \Exception $e )
				{
					$this->writeException( $e );
				}
			}

			if( $this->getInput()
				->hasOption( "bootstrap" ) )
			{
				$bootstrap = $this->getInput()
					->getOption( "bootstrap" );

				try
				{
					if( NULL === $bootstrap )
					{
						$this->writeInfo( sprintf( "Finder Boostrap not set.", $bootstrap ), OutputInterface::VERBOSITY_VERY_VERBOSE );
					}
					elseif( file_exists( $bootstrap ) )
					{
						@require_once $bootstrap;

						$finder->append( array(
							$bootstrap
						) );
						$this->writeInfo( sprintf( "Finder Adding Boostrap'%s'", $bootstrap ), OutputInterface::VERBOSITY_VERY_VERBOSE );
					}
					else
					{
						$this->writeInfo( sprintf( "Finder Boostrap '%s' not exists.", $bootstrap ), OutputInterface::VERBOSITY_VERY_VERBOSE );
					}
				}
				catch( \Exception $e )
				{
					$this->writeException( $e );
				}
			}

			if( $this->getInput()
				->hasOption( "followLinks" ) )
			{
				try
				{
					$followLinks = $this->getInput()
						->getOption( "followLinks" );

					if( true === $followLinks )
					{
						$finder->followLinks();
					}

					$this->writeInfo(
						sprintf( "Finder following links '%s'.", $followLinks ? 'yes' : 'no' ),
						OutputInterface::VERBOSITY_VERY_VERBOSE );
				}
				catch( \Exception $e )
				{
					$this->writeException( $e );
				}
			}

			if( $this->getInput()
				->hasOption( "ignoreDotFiles" ) )
			{
				try
				{
					$ignoreDotFiles = $this->getInput()
						->getOption( "ignoreDotFiles" );

					$finder->ignoreDotFiles( $ignoreDotFiles );

					$this->writeInfo(
						sprintf( "Finder ignoring dot files '%s'.", $ignoreDotFiles ? 'yes' : 'no' ),
						OutputInterface::VERBOSITY_VERY_VERBOSE );
				}
				catch( \Exception $e )
				{
					$this->writeException( $e );
				}
			}

			if( $this->getInput()
				->hasOption( "fileSuffix" ) )
			{
				try
				{
					$fileSuffix = $this->getInput()
						->getOption( "fileSuffix" );
					$finder->name( $fileSuffix );

					$this->writeInfo( sprintf( "Finder applying file suffix '%s'.", $fileSuffix ), OutputInterface::VERBOSITY_VERY_VERBOSE );
				}
				catch( \Exception $e )
				{
					$this->writeException( $e );
				}
			}

			$exclude = $this->getInput()
				->getOption( "exclude" );

			if( $this->getInput()
				->hasOption( "exclude" ) && $exclude )
			{
				try
				{
					$finder->exclude( $this->getInput()
						->getOption( "exclude" ) );

					$this->writeInfo( sprintf( "Finder applying exclude '%s'.", implode( ",", $exclude ) ), OutputInterface::VERBOSITY_VERY_VERBOSE );
				}
				catch( \Exception $e )
				{
					$this->writeException( $e );
				}
			}

			$this->setFinder( $finder, $name );
		}

		return $this->finders[ $name ];

	}

	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::configure()
	 */
	protected function configure()
	{

		parent::configure();

		$this->addOption( "bootstrap", "bs", InputOption::VALUE_OPTIONAL, "PHP Boostrap File." );
		$this->addOption(
			"attributeName",
			"an",
			InputOption::VALUE_OPTIONAL,
			"Attributes name, e.g. '^myPrefix|mySuffix$', regular expression allowed." );
		$this->addOption( "ignoreDotFiles", "df", InputOption::VALUE_OPTIONAL, "Ignore DOT files.", true );
		$this->addOption(
			"operationName",
			"on",
			InputOption::VALUE_OPTIONAL,
			"Operations name, e.g. '^myPrefix|mySuffix$', regular expression allowed.",
			NULL );
		$this->addOption(
			"operationAttributeName",
			"oa",
			InputOption::VALUE_OPTIONAL,
			"Operations Attributes name, e.g. '^myPrefix|mySuffix$', regular expression allowed." );

		$this->addOption( "accessibility", "ac", InputOption::VALUE_OPTIONAL, "Operations and attributes accessibility: protected, public, private." );
		$this->addOption( "parentClass", "pc", InputOption::VALUE_REQUIRED | InputOption::VALUE_IS_ARRAY, "Parent Class Name, e.g 'My\Class'" );
		$this->addOption( "fileSuffix", "fs", InputOption::VALUE_OPTIONAL, "File suffixes for given src, default all and not dot files.", "*.php" );
		$this->addOption( "followLinks", "fl", InputOption::VALUE_OPTIONAL, "Follows links.", false );

		$this->addOption( "is-interface", "ii", InputOption::VALUE_REQUIRED, "Reflect Interfaces Objects Only, possible values are (true|false)." );
		$this->addOption( "is-trait", "it", InputOption::VALUE_REQUIRED, "Reflect Traits Objects Only, possible values are (true|false)." );
		$this->addOption( "is-abstract-class", "ib", InputOption::VALUE_REQUIRED, "Reflect Abstract Classes Only, possible values are (true|false)." );
		$this->addOption( "is-final", "if", InputOption::VALUE_REQUIRED, "Reflect Final Classes Only, possible values are (true|false)." );
		$this->addOption( "is-abstract", "ia", InputOption::VALUE_REQUIRED, "Reflect Abstract Classes Only, possible values are (true|false)." );
		$this->addOption(
			"is-private",
			"ip",
			InputOption::VALUE_REQUIRED,
			"Reflect Private Operations or Attributes, possible values are (true|false)." );
		$this->addOption(
			"is-protected",
			"id",
			InputOption::VALUE_REQUIRED,
			"Reflect Protected Operations or Attributes, possible values are (true|false)." );
		$this->addOption(
			"is-public",
			"ic",
			InputOption::VALUE_REQUIRED,
			"Reflect Public Operations or Attributes, possible values are (true|false)." );
		$this->addOption(
			"is-static",
			"is",
			InputOption::VALUE_REQUIRED,
			"Reflect Static Operations or Attributes, possible values are (true|false)." );
		$this->addOption( "implements-interface", "imi", InputOption::VALUE_REQUIRED | InputOption::VALUE_IS_ARRAY, "Reflect Abstract Classes Only." );
		$this->addOption( "exclude", "ed", InputOption::VALUE_REQUIRED | InputOption::VALUE_IS_ARRAY, "Exclude Directory from source" );

		$this->addArgument( 'src', InputArgument::IS_ARRAY, 'PHP Source directory', array(
			"src/",
			"app/",
			"tests/"
		) );

	}

	/**
	 *
	 * @param array $src
	 */
	public function setSrc(
		array $src )
	{

		$root = $this->getRootDir();

		foreach( $src as $directory )
		{
			$directory = $root . DIRECTORY_SEPARATOR . $directory;

			if( file_exists( $directory ) )
			{
				$this->src[] = $directory;
			}
		}

		return $this;

	}

	/**
	 *
	 * @param string $class
	 * @return array
	 */
	protected function getNamespace(
		$class )
	{

		$names = explode( "\\", $class );
		$className = array_pop( $names );

		return array(
			'namespace' => implode( "\\", $names ),
			'class' => $className
		);

	}

	/**
	 * Gets SK ITCBundle Command Code Generator Class Reflection
	 *
	 * @return ReflectionClass[]
	 */
	public function getClassReflections()
	{

		if( NULL === $this->classReflections )
		{
			/* This should be called pro forma due Broker Class reflection */
			$fileReflections = $this->getFileRelections();
			$this->writeInfo( sprintf( "Searching class reflection in '%d' files.", count( $fileReflections ) ) );

			$input = $this->getInput();
			/* @var $classReflections ReflectionClass[] */
			$classReflections = $this->getBroker()
				->getClasses( Backend::TOKENIZED_CLASSES, Backend::INTERNAL_CLASSES );

			$classReflections = array_filter(
				$classReflections,
				function (
					$classReflection ) use (
				$input )
				{
					$this->writeInfo(
						sprintf( "Processing class reflection '%s'.", $classReflection->getName() ),
						OutputInterface::VERBOSITY_VERBOSE );

					$isAbstract = $input->getOption( "is-abstract-class" );
					if( NULL !== $isAbstract )
					{

						if( $isAbstract == "false" )
						{

							$isAbstract = false;
						}
						else
						{
							$isAbstract = true;
						}
						return ($isAbstract == $classReflection->isAbstract());
					}

					$isInterface = $input->getOption( "is-interface" );
					if( NULL !== $isInterface )
					{
						if( $isInterface == "false" )
						{
							$isInterface = false;
						}
						else
						{
							$isInterface = true;
						}
						return ($isInterface == $classReflection->isInterface());
					}

					$isTrait = $input->getOption( "is-trait" );
					if( NULL !== $isTrait )
					{
						if( $isTrait == "false" )
						{
							$isTrait = false;
						}
						else
						{
							$isTrait = true;
						}
						return ($isTrait == $classReflection->isTrait());
					}

					$isFinal = $input->getOption( "is-final" );
					if( NULL !== $isFinal )
					{
						if( $isFinal == "false" )
						{
							$isFinal = false;
						}
						else
						{
							$isFinal = true;
						}
						return ($isFinal == $classReflection->isFinal());
					}

					$parentClasses = $input->getOption( "parentClass" );
					if( count( $parentClasses ) > 0 )
					{
						foreach( $parentClasses as $parentClass )
						{
							if( in_array( $parentClass, $classReflection->getParentClassNameList() ) )
							{
								return true;
							}
						}
						return false;
					}

					$implementsInterfaces = $input->getOption( "implements-interface" );
					if( count( $implementsInterfaces ) > 0 )
					{
						foreach( $implementsInterfaces as $implementsInterface )
						{
							if( in_array( $implementsInterface, $classReflection->getInterfaceNames() ) )
							{
								return true;
							}
						}
						return false;
					}

					return true;
				} );

			$this->setClassReflections( $classReflections );

			$this->writeInfo(
				sprintf(
					"Found '%d' classes with '%d' errors in '%d' files.",
					count( $classReflections ),
					count( $this->getExceptions() ),
					count( $fileReflections ) ) );
		}

		return $this->classReflections;

	}

	/**
	 * Gets SK ITCBundle Command Code Generator Class Reflection
	 *
	 * @param string $className
	 * @return ReflectionClass
	 */
	public function getClassReflection(
		$className )
	{

		$classReflections = $this->getClassReflections();

		if( ! isset( $classReflections[ $className ] ) )
		{
			throw new \Exception( sprintf( "Class reflection '%s' is not set.", $className ) );
		}

		return $classReflections[ $className ];

	}

	/**
	 * Sets SK ITCBundle Command Code Generator Class Reflections
	 *
	 * @param ReflectionClass[] $classReflections
	 * @return \SK\ITCBundle\Command\Tests\AbstractGenerator
	 */
	public function setClassReflections(
		$classReflections )
	{

		$this->classReflections = $classReflections;
		return $this;

	}

	/**
	 * Sets SK ITCBundle Command Code Generator Finder
	 *
	 * @param Finder $finder
	 *        	SK ITCBundle Command Code Generator Finder
	 * @param string $name
	 * @return \SK\ITCBundle\Command\Code\CodeCommand
	 */
	public function setFinder(
		Finder $finder,
		$name = null )
	{

		if( null === $name )
		{
			$name = 0;
		}

		$this->finders[ $name ] = $finder;

		return $this;

	}

	/**
	 * Sets SK ITCBundle Command Code Generator Broker
	 *
	 * @param Broker $broker
	 *        	SK ITCBundle Command Code Generator Broker
	 * @return \SK\ITCBundle\Command\Code\CodeCommand
	 */
	public function setBroker(
		Broker $broker )
	{

		$this->broker = $broker;
		return $this;

	}

	/**
	 * Sets SK ITCBundle Command Code Generator Operations Reflections
	 *
	 * @return ReflectionMethod[]
	 */
	public function getOperationsReflections()
	{

		if( null === $this->operationsReflections )
		{
			$classReflections = $this->getClassReflections();
			$this->writeInfo( sprintf( "Searching class operations in '%s' classes.", count( $classReflections ) ) );

			$operationsReflections = [];
			$input = $this->getInput();

			$operationPattern = NULL;
			$operationName = $this->getInput()
				->getOption( 'operationName' );

			if( NULL !== $operationName )
			{
				$operationPattern = sprintf( "/%s/", $operationName );
			}

			foreach( $classReflections as $classReflection )
			{
				/* @var $operationReflection ReflectionMethod[] */
				$classOperationReflections = $classReflection->getMethods();

				$classOperationReflections = array_filter(
					$classOperationReflections,
					function (
						$classOperationReflection ) use (
							$input,
							$operationPattern )
					{
						/* @var $classOperationReflection ReflectionMethod */
						$this->writeInfo(
							sprintf( "Processing class operation reflection '%s'.", $classOperationReflection->getName() ),
							OutputInterface::VERBOSITY_VERBOSE );

						if( NULL !== $operationPattern )
						{
							return preg_match( $operationPattern, $classOperationReflection->getName() );
						}

						$isAbstract = $input->getOption( "is-abstract" );
						if( NULL !== $isAbstract )
						{

							if( $isAbstract == "false" )
							{

								$isAbstract = false;
							}
							else
							{
								$isAbstract = true;
							}
							return ($isAbstract == $classOperationReflection->isAbstract());
						}

						$isPrivate = $input->getOption( "is-private" );
						if( NULL !== $isPrivate )
						{
							if( $isPrivate == "false" )
							{
								$isPrivate = false;
							}
							else
							{
								$isPrivate = true;
							}
							return ($isPrivate == $classOperationReflection->isPrivate());
						}

						$isPublic = $input->getOption( "is-public" );
						if( NULL !== $isPublic )
						{
							if( $isPublic == "false" )
							{
								$isPublic = false;
							}
							else
							{
								$isPublic = true;
							}
							return ($isPublic == $classOperationReflection->isPublic());
						}

						$isProtected = $input->getOption( "is-protected" );
						if( NULL !== $isProtected )
						{
							if( $isProtected == "false" )
							{
								$isProtected = false;
							}
							else
							{
								$isProtected = true;
							}
							return ($isProtected == $classOperationReflection->isProtected());
						}

						$isStatic = $input->getOption( "is-static" );
						if( NULL !== $isStatic )
						{

							if( $isStatic == "false" )
							{

								$isStatic = false;
							}
							else
							{
								$isStatic = true;
							}
							return ($isStatic == $classOperationReflection->isStatic());
						}
					} );
				$operationsReflections=array_merge($operationsReflections,$classOperationReflections);
			}
			$this->setOperationsReflections( $operationsReflections );
			$this->writeInfo(
				sprintf( "Found '%d' Operations in '%d' Classes.", count( $this->getOperationsReflections() ), count( $this->getClassReflections() ) ) );
		}
		return $this->operationsReflections;

	}

	/**
	 * Gets SK ITCBundle Command Code Generator Operations Reflections
	 *
	 * @param ReflectionMethod[] $operationsReflections
	 * @return \SK\ITCBundle\Command\Code\CodeCommand
	 */
	public function setOperationsReflections(
		array $operationsReflections )
	{

		$this->operationsReflections = $operationsReflections;
		return $this;

	}

	/**
	 * Gets SK ITCBundle Command Code Generator File Reflections
	 *
	 * @param string $filename
	 *        	SK ITCBundle Command Code Generator File Reflections FileName
	 * @return ReflectionFile
	 * @throws \Exception
	 */
	public function getFileRelection(
		$filename )
	{

		$fileReflections = $this->getFileRelections();
		if( in_array( $filename, $fileReflections ) )
		{
			return $fileReflections[ $filename ];
		}
		throw new \Exception( sprintf( "No '%s' file reflection exists.", $filename ) );

	}

	/**
	 * Gets SK ITCBundle Command Code Generator File Reflections
	 *
	 * @return ReflectionFile[]
	 */
	public function getFileRelections()
	{

		if( null === $this->fileRelections )
		{
			$src = $this->getInput()
				->getArgument( 'src' );

			$this->writeInfo( sprintf( "Searching files in '%s' sources.", implode( "', '", $src ) ) );

			/* @var $fileReflection ReflectionFile[] */
			$fileReflections = [];

			foreach( $this->getFinder()
				->files() as $fileName )
			{
				try
				{
					/* @var $fileReflection ReflectionFile */
					$fileReflection = $this->getBroker()
						->processFile( $fileName, true );

					$fileReflections[] = $fileReflection;
				}
				catch( \Exception $exception )
				{
					$this->addException( $exception );
				}
			}
			$this->setFileRelections( $fileReflections );

			$this->writeInfo(
				sprintf( "Found '%d' files reflected with '%d' exceptions.", count( $fileReflections ), count( $this->getExceptions() ) ) );
		}

		return $this->fileRelections;

	}

	/**
	 * Sets SK ITCBundle Command Code Generator File Reflections
	 *
	 * @param ReflectionFile[] $fileRelections
	 * @return \SK\ITCBundle\Command\Code\CodeCommand
	 */
	public function setFileRelections(
		array $fileRelections )
	{

		$this->fileRelections = $fileRelections;
		return $this;

	}

	/**
	 * Sets SK ITCBundle Command Code Generator File Reflection
	 *
	 * @param ReflectionFile $fileRelection
	 *        	SK ITCBundle Command Code Generator File Reflection
	 * @return \SK\ITCBundle\Command\Code\CodeCommand
	 */
	public function setFileRelection(
		array $fileRelections )
	{

		$this->fileRelections = $fileRelections;
		return $this;

	}

	/**
	 *
	 * @return the Reflection
	 */
	protected function getReflection()
	{

		return $this->reflection;

	}

	/**
	 *
	 * @param Reflection $reflection
	 */
	protected function setReflection(
		Reflection $reflection )
	{

		$this->reflection = $reflection;
		return $this;

	}

}