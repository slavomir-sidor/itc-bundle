<?php

namespace SK\ITCBundle\Command\Code;

use Symfony\Component\Console\Command\Command;
use SK\ITCBundle\Command\AbstractCommand;
use Symfony\Component\Console\Input\InputArgument;
use Zend\Code\Reflection\FileReflection;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Helper\ProgressBar;
use Symfony\Component\Finder\Finder;
use Symfony\Component\Console\Input\InputOption;
use TokenReflection\Broker;
use TokenReflection\ReflectionFile;
use TokenReflection\ReflectionClass;
use TokenReflection\Broker\Backend;
use TokenReflection\ReflectionMethod;

/**
 * SK ITCBundle Command Abstract
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
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

			$this->writeInfo( sprintf( "Initializing Code in sources '%s'.", implode( ", ", $src ) ), OutputInterface::VERBOSITY_VERBOSE );

			foreach( $src as $source )
			{
				try
				{

					if( ! file_exists( $source ) )
					{
						$this->writeNotice( sprintf( "Source '%s' not Exists.", $source ), OutputInterface::VERBOSITY_VERY_VERBOSE );
					}

					if( is_dir( $source ) )
					{
						$finder->in( $source );
						$this->writeNotice( sprintf( "Adding directory '%s'.", $source ), OutputInterface::VERBOSITY_VERY_VERBOSE );
					}

					if( is_file( $source ) )
					{
						$finder->append( array($source) );

						$this->writeNotice( sprintf( "Adding file '%s'.", $source ), OutputInterface::VERBOSITY_VERY_VERBOSE );
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
						$this->writeNotice( sprintf( "Boostrap not set.", $bootstrap ), OutputInterface::VERBOSITY_VERY_VERBOSE );
					}
					elseif( file_exists( $bootstrap ) )
					{
						@require_once $bootstrap;

						$finder->append( array(
							$bootstrap
						) );
						$this->writeNotice( sprintf( "Finder Adding Boostrap'%s'", $bootstrap ), OutputInterface::VERBOSITY_VERY_VERBOSE );
					}
					else
					{
						$this->writeNotice( sprintf( "Boostrap '%s' not exists.", $bootstrap ), OutputInterface::VERBOSITY_VERY_VERBOSE );
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

					$this->writeNotice(
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

					$this->writeNotice(
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

					$this->writeNotice( sprintf( "Finder applying file suffix '%s'.", $fileSuffix ), OutputInterface::VERBOSITY_VERY_VERBOSE );
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

					$this->writeNotice(
						sprintf( "Finder applying exclude '%s'.", implode( ",", $exclude ) ),
						OutputInterface::VERBOSITY_VERY_VERBOSE );
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
	 * @see \Symfony\Component\Console\Command\Command::execute()
	 */
	public function execute(
		InputInterface $input,
		OutputInterface $output )
	{

		parent::execute( $input, $output );
		$this->setSrc( $input->getArgument( 'src' ) );

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
			"Operations name, e.g. '^myPrefix|mySuffix$', regular expression allowed." );
		$this->addOption(
			"operationAttributeName",
			"oa",
			InputOption::VALUE_OPTIONAL,
			"Operations Attributes name, e.g. '^myPrefix|mySuffix$', regular expression allowed." );
		$this->addOption(
			"operationFilter",
			"op",
			InputOption::VALUE_OPTIONAL,
			"Operations filter : Abstract,Final, Private, Protected, Public, Static." );
		$this->addOption( "parentClass", "pc", InputOption::VALUE_OPTIONAL, "Parent Class Name, e.g 'My\Class'" );
		$this->addOption( "fileSuffix", "fs", InputOption::VALUE_OPTIONAL, "File suffixes for given src, default all and not dot files.", "*.php" );
		$this->addOption( "followLinks", "fl", InputOption::VALUE_OPTIONAL, "Follows links.", false );
		$this->addOption( "exclude", "ed", InputOption::VALUE_REQUIRED | InputOption::VALUE_IS_ARRAY, "Exclude Directory from source" );

		$this->addArgument( 'src', InputArgument::IS_ARRAY, 'PHP Source directory', array(
			"./src",
			"./app",
			"./tests"
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
			/* @var $classReflections ReflectionClass[] */
			$classReflections = [];

			/* @var $exceptions \Exception[] */
			$exceptions = [];

			foreach( $this->getFinder()
				->files() as $fileName )
			{
				try
				{
					/* @var $fileReflection ReflectionFile */
					$fileReflection = $this->getBroker()
						->processFile( $fileName );
				}
				catch( \Exception $exception )
				{
					$this->addException( $exception );
				}
			}

			$classReflections = $this->getBroker()
				->getClasses( Backend::TOKENIZED_CLASSES, Backend::INTERNAL_CLASSES );

			$parentClass = $this->getInput()
				->getOption( "parentClass" );

			if( NULL !== $parentClass )
			{
				$this->writeNotice( sprintf( "Searching for classes inherited from '%s'", $parentClass ), OutputInterface::VERBOSITY_VERBOSE );

				foreach( $classReflections as $key => $classReflection )
				{
					if( ! in_array( $parentClass, $classReflection->getParentClassNameList() ) )
					{
						unset( $classReflections[ $key ] );
					}
				}
			}

			$this->setClassReflections( $classReflections );

			$this->writeNotice(
				sprintf( "Found '%d' classes with %d errors.", count( $this->getClassReflections() ), count( $this->getExceptions() ) ),
				OutputInterface::VERBOSITY_VERBOSE );
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

		$this->writeInfo( sprintf( "Found %d files.", $finder->count() ), OutputInterface::VERBOSITY_VERBOSE );

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
	public function getOperationsReflections(
		$className = NULL )
	{

		if( null === $this->operationsReflections )
		{
			$classReflections = $this->getClassReflections();

			$this->writeInfo(
				sprintf( "Searching class operations in '%s' classes.", count( $classReflections ) ),
				OutputInterface::VERBOSITY_VERBOSE );

			$operationsReflections = [];

			/**
			 *
			 * @todo add operation filter for class reflections
			 *       $operationFilter = $this->getInput()->getOption('operationFilter');
			 */

			if( $this->getInput()
				->hasOption( 'operationName' ) )
			{
				$operationPattern = sprintf( "/%s/", $this->getInput()
					->getOption( 'operationName' ) );
			}

			foreach( $classReflections as $classReflection )
			{

				/* @var $operationReflection ReflectionMethod[] */
				$classOperationReflections = $classReflection->getMethods();

				foreach( $classOperationReflections as $operationReflection )
				{
					if( $operationPattern !== "" && ! preg_match( $operationPattern, $operationReflection->getName() ) )
					{
						continue;
					}
					$operationsReflections[] = $operationReflection;
				}
			}
			$this->setOperationsReflections( $operationsReflections );
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

		$this->writeInfo(
			sprintf( "'%d' Operations in '%d' Classes.", count( $this->getOperationsReflections() ), count( $this->getClassReflections() ) ),
			OutputInterface::VERBOSITY_VERBOSE );
		return $this;

	}

	/**
	 * Gets SK ITCBundle Command Code Generator File Reflections
	 *
	 * @return the ReflectionFile[]
	 */
	public function getFileRelections()
	{

		return $this->fileRelections;

	}

	/**
	 * Sets SK ITCBundle Command Code Generator File Reflections
	 *
	 * @param ReflectionFile[] $fileRelections
	 * @return \SK\ITCBundle\Command\Code\CodeCommand
	 */
	public function setFileRelections(
		$fileRelections )
	{

		$this->fileRelections = $fileRelections;
		return $this;

	}

}