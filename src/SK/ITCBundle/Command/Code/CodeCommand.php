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
	 *
	 * @var Reflection $reflection
	 */
	protected $reflection;

	/**
	 * SK ITCBundle Code Generator Finder
	 *
	 * @var array
	 */
	protected $files;

	/**
	 * SK ITCBundle Command Code Generator Class Reflection
	 *
	 * @var array
	 */
	protected $packages;

	/**
	 * SK ITCBundle Command Code Generator Class Reflection
	 *
	 * @var array
	 */
	protected $classes;

	/**
	 * SK ITCBundle Command Code Generator Operations Reflection
	 *
	 * @var array
	 */
	protected $properties;

	/**
	 * SK ITCBundle Command Code Generator Operations Reflection
	 *
	 * @var array
	 */
	protected $operations;

	/**
	 * SK ITCBundle Command Code Generator Operations Reflection
	 *
	 * @var array
	 */
	protected $parameters;

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
	 * @return array
	 */
	protected function getClassReflections()
	{

		if( NULL === $this->classReflections )
		{
			/* This should be called pro forma due Broker Class reflection */
			$fileReflections = $this->getFileReflections();

			$this->writeInfo( sprintf( "Searching class reflection in '%d' files.", count( $fileReflections ) ) );
			$input = $this->getInput();
			/* @var $classReflections ReflectionClass[] */
			$classReflections = $this->getReflection()
				->getClassReflections();

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

			$rows = [];
			foreach( $classReflections as $classReflection )
			{
				$row = [];
				if( $classReflection->isTrait() )
				{
					$row[ 'object' ] = "Trait";
				}
				elseif( $classReflection->isInterface() )
				{
					$row[ 'object' ] = "Interface";
				}
				else
				{
					$row[ 'object' ] = "Class";
				}
				$row[ 'final' ] = $classReflection->isFinal() ? "Final" : "";
				$row[ 'abstract' ] = $classReflection->isAbstract() ? "Abstract" : "";
				$row[ 'name' ] = $classReflection->getName();
				$row[ 'parent' ] = implode( "\n", $classReflection->getParentClassNameList() );
				$row[ 'interface' ] = implode( "\n", $classReflection->getInterfaceNames() );

				$rows[] = $row;
			}

			$this->setClassReflections( $rows );
		}

		return $this->classReflections;

	}

	/**
	 * Sets SK ITCBundle Command Code Generator Class Reflections
	 *
	 * @param array $classReflections
	 * @return \SK\ITCBundle\Command\Tests\AbstractGenerator
	 */
	protected function setClassReflections(
		array $classReflections )
	{

		$this->classReflections = $classReflections;
		$this->writeInfo( sprintf( "Found '%d' classes.", count( $classReflections ) ) );
		return $this;

	}

	/**
	 * Sets SK ITCBundle Command Code Generator Operations Reflections
	 *
	 * @return ReflectionMethod[]
	 */
	protected function getOperationsReflections()
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

			foreach( $classReflections as $className => $classReflection )
			{
				$classReflection = $this->getReflection()
					->getClassReflection( $classReflection[ 'name' ] );

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
				$operationsReflections = array_merge( $operationsReflections, $classOperationReflections );
			}

			$rows = [];

			foreach( $operationsReflections as $operationReflection )
			{
				$operationsParametersReflections = $operationReflection->getParameters();
				$operationsParameters = [];
				foreach( $operationsParametersReflections as $parameter )
				{
					$operationsParameters[] = $parameter->getName();
				}
				$annotations = $operationReflection->getAnnotations();
				$accesibility = "";
				if( $operationReflection->isPrivate() )
				{
					$accesibility = "Private";
				}
				if( $operationReflection->isProtected() )
				{
					$accesibility = "Protected";
				}
				if( $operationReflection->isPublic() )
				{
					$accesibility = "Public";
				}

				$rows[] = array(
					$accesibility,
					$operationReflection->isAbstract() ? "Abstract" : "",
					$operationReflection->isStatic() ? "Static" : "",
					sprintf( '%s::%s', $operationReflection->getDeclaringClassName(), $operationReflection->getName() ),
					implode( ', ', $operationsParameters ),
					(isset( $annotations[ 'return' ] ) && isset( $annotations[ 'return' ][ 0 ] )) ? $annotations[ 'return' ][ 0 ] : ''
				);
			}

			$this->setOperationsReflections( $rows );
		}
		return $this->operationsReflections;

	}

	/**
	 * Gets SK ITCBundle Command Code Generator Operations Reflections
	 *
	 * @param array $operationsReflections
	 * @return \SK\ITCBundle\Command\Code\CodeCommand
	 */
	protected function setOperationsReflections(
		array $operationsReflections )
	{

		$this->operationsReflections = $operationsReflections;
		$this->writeInfo(
			sprintf( "Found '%d' Operations in '%d' Classes.", count( $this->getOperationsReflections() ), count( $this->getClassReflections() ) ) );
		return $this;

	}

	/**
	 * Gets SK ITCBundle Command Code Generator Operations Reflections
	 *
	 * @param array $operationsReflections
	 * @return \SK\ITCBundle\Command\Code\CodeCommand
	 */
	protected function setOperationsAttributes(
		array $operationsReflections )
	{

		$this->operationsReflections = $operationsReflections;
		$this->writeInfo(
			sprintf( "Found '%d' Operations in '%d' Classes.", count( $this->getOperationsReflections() ), count( $this->getClassReflections() ) ) );
		return $this;

	}

	/**
	 * Sets SK ITCBundle Command Code Generator File Reflections
	 *
	 * @param array $fileRelections
	 * @return \SK\ITCBundle\Command\Code\CodeCommand
	 */
	protected function setFileReflections(
		array $fileRelections )
	{

		$this->fileRelections = $fileRelections;
		$this->writeInfo( sprintf( "Found '%d' files.", count( $fileRelections ) ) );
		return $this;

	}

	/**
	 *
	 * @return Reflection
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

	/**
	 *
	 * @return array
	 */
	protected function getFiles()
	{
		if(null===$this->files){
			$src = $this->getInput()
			->getArgument( "src" );

			$this->writeInfo( sprintf( "Searching files in '%s' sources.", implode( "', '", $src ) ) );
			$finder = $this->getReflection()
			->getFinder();
			/**
			 * Finder has to have at minimum one file.
			 */
			$canContinue = false;
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
						$canContinue = true;
						$finder->in( $source );
						$this->writeInfo( sprintf( "Finder Adding directory '%s'.", $source ), OutputInterface::VERBOSITY_VERY_VERBOSE );
					}

					if( is_file( $source ) )
					{
						$canContinue = true;
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

			$fileReflections = [];
			/* @var FileReflection $fileReflection */
			foreach( $this->getReflection()
					->getFiles() as $fileReflection )
			{
				$file = new \SplFileInfo( $fileReflection->getName() );
				$row = array(
						$file->getPathName(),
						$file->getOwner(),
						$file->getGroup(),
						$file->getPerms(),
						date( "d.m.Y h:m:s", $file->getCTime() ),
						date( "d.m.Y h:m:s", $file->getMTime() )
				);
				$fileReflections[] = $row;
			}

			$this->setFiles( $fileReflections );
		}
		return $this->files;

	}

	/**
	 *
	 * @param array $files
	 */
	protected function setFiles(
		array $files )
	{

		$this->files = $files;
		return $this;

	}

	/**
	 *
	 * @return array
	 */
	protected function getPackages()
	{

		return $this->packages;

	}

	/**
	 *
	 * @param array $packages
	 */
	protected function setPackages(
		array $packages )
	{

		$this->packages = $packages;
		return $this;

	}

	/**
	 *
	 * @return array
	 */
	protected function getClasses()
	{

		return $this->classes;

	}

	/**
	 *
	 * @param array $classes
	 */
	protected function setClasses(
		array $classes )
	{

		$this->classes = $classes;
		return $this;

	}

	/**
	 *
	 * @return array
	 */
	protected function getProperties()
	{

		return $this->properties;

	}

	/**
	 *
	 * @param array $properties
	 */
	protected function setProperties(
		array $properties )
	{

		$this->properties = $properties;
		return $this;

	}

	/**
	 *
	 * @return array
	 */
	protected function getOperations()
	{

		return $this->operations;

	}

	/**
	 *
	 * @param array $operations
	 */
	protected function setOperations(
		array $operations )
	{

		$this->operations = $operations;
		return $this;

	}

	/**
	 *
	 * @return array
	 */
	protected function getParameters()
	{

		return $this->parameters;

	}

	/**
	 *
	 * @param array $parameters
	 */
	protected function setParameters(
		array $parameters )
	{

		$this->parameters = $parameters;
		return $this;

	}

}