<?php
namespace SK\ITCBundle\Code\Reflection;

use Monolog\Logger;
use TokenReflection\Broker;
use Symfony\Component\Finder\Finder;
use TokenReflection\Broker\Backend;
use TokenReflection\ReflectionFile;
use TokenReflection\Php\ReflectionProperty;
use TokenReflection\Php\ReflectionMethod;
use TokenReflection\Php\ReflectionParameter;
use SK\ITCBundle\Code\Reflection\Collection\PackageCollection;
use SK\ITCBundle\Code\Reflection\Collection\FileCollection;
use SK\ITCBundle\Code\Reflection\Collection\ClassCollection;
use SK\ITCBundle\Code\Reflection\Collection\OperationCollection;
use SK\ITCBundle\Code\Reflection\Collection\ParameterCollection;
use SK\ITCBundle\Code\Reflection\Collection\AttributesCollection;
use TokenReflection\ReflectionNamespace;
use TokenReflection\Php\ReflectionClass;

class Reflection
{

	/**
	 *
	 * @var FileCollection
	 */
	protected $files;

	/**
	 *
	 * @var PackageCollection
	 */
	protected $packages;

	/**
	 *
	 * @var ClassCollection
	 */
	protected $classes;

	/**
	 *
	 * @var PropertyCollection
	 */
	protected $attributes;

	/**
	 *
	 * @var OperationCollection
	 */
	protected $operations;

	/**
	 *
	 * @var ParameterCollection
	 */
	protected $parameters;

	/**
	 *
	 * @var Finder
	 */
	protected $finder;

	/**
	 *
	 * @var Broker
	 */
	protected $broker;

	/**
	 *
	 * @var Logger
	 */
	protected $logger;

	/**
	 * Constructs SK ITCBundle Code Generator
	 *
	 * @param Logger $logger
	 *        	SK ITCBundle Abstract Command Logger
	 */
	public function __construct( Logger $logger )
	{
		$this->setLogger( $logger );
	}

	/**
	 *
	 * @return Broker
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
	 *
	 * @return ClassCollection
	 */
	public function getClasses()
	{
		if( null === $this->classes )
		{
			$classes = new ClassCollection();

			/* @var $file ReflectionFile*/
			foreach( $this->getFiles() as $file )
			{
				/* @var $file ReflectionNamespace */
				foreach( $file->getNamespaces() as $namespace )
				{
					/* @var $class ReflectionClass */
					foreach( $namespace->getClasses() as $class )
					{
						$classes->set( $class->getName(), $class );
					}
				}
			}

			$this->setClasses( $classes );
		}
		return $this->classes;
	}

	/**
	 *
	 * @param ClassCollection $classes
	 */
	public function setClasses( ClassCollection $classes )
	{
		$this->classes = $classes;
		return $this;
	}

	/**
	 *
	 * @return OperationCollection
	 */
	public function getOperations()
	{
		if( null === $this->operations )
		{
			$operations = [];

			/* @var $class ReflectionClass */
			foreach( $this->getClasses() as $class )
			{
				/* @var $class ReflectionMethods */
				foreach( $class->getMethods() as $operation )
				{
					$operations[] = $operation;
				}
			}

			$this->setOperations( new OperationCollection( $operations ) );
		}
		return $this->operations;
	}

	/**
	 *
	 * @param OperationCollection $operationsReflections
	 */
	public function setOperations( OperationCollection $operations )
	{
		$this->operations = $operations;
		return $this;
	}

	/**
	 *
	 * @return Finder
	 */
	public function getFinder()
	{
		if( null === $this->finder )
		{
			$finder = new Finder();
			$this->setFinder( $finder );
		}
		return $this->finder;
	}

	/**
	 *
	 * @param Finder $finder
	 * @return Reflection
	 */
	public function setFinder( Finder $finder )
	{
		$this->finder = $finder;
		return $this;
	}

	/**
	 *
	 * @param string $filename
	 *        	SK ITCBundle Command Code Generator File Reflections FileName
	 * @return ReflectionFile
	 * @throws \Exception
	 */
	public function getFile( $filename )
	{
		return $this->getFiles()
			->get( $filename );
	}

	/**
	 *
	 * @return FileCollection
	 */
	public function getFiles()
	{
		if( null === $this->files )
		{
			$files = new FileCollection();
			$finder = $this->getFinder();

			foreach( $finder->files() as $fileName )
			{
				try
				{
					/* @var $fileReflection ReflectionFile */
					$file = $this->getBroker()
						->processFile( $fileName, true );

					$files->set( $file->getName(), $file );
				}
				catch( \Exception $exception )
				{
					$this->getLogger()
						->log( Logger::NOTICE, $exception->getMessage() );
				}
			}

			$this->setFiles( $files );
		}
		return $this->files;
	}

	/**
	 *
	 * @param FileCollection $files
	 */
	public function setFiles( FileCollection $files )
	{
		$this->files = $files;
		return $this;
	}

	/**
	 *
	 * @param Broker $broker
	 */
	public function setBroker( Broker $broker )
	{
		$this->broker = $broker;
		return $this;
	}

	/**
	 *
	 * @return Logger
	 */
	public function getLogger()
	{
		return $this->logger;
	}

	/**
	 *
	 * @param Logger $logger
	 * @return Reflection
	 */
	public function setLogger( Logger $logger )
	{
		$this->logger = $logger;
		return $this;
	}

	/**
	 *
	 * @return PackageCollection
	 */
	public function getPackages()
	{
		if( null === $this->packages )
		{
			$packages = new PackageCollection();

			/* @var $file ReflectionFile*/
			foreach( $this->getFiles() as $file )
			{
				/* @var $package ReflectionNamespace */
				foreach( $file->getNamespaces() as $package )
				{
					$packages->set( $package->getName(), $package );
				}
			}

			$this->setPackages( $packages );
		}
		return $this->packages;
	}

	public function setPackages( PackageCollection $packages )
	{
		$this->packages = $packages;
		return $this;
	}

	/**
	 *
	 * @return AttributesCollection
	 */
	public function getAttributes()
	{
		if( null === $this->attributes )
		{
			$attributes = [];

			/* @var $class ReflectionClass */
			foreach( $this->getClasses() as $class )
			{
				/* @var $property ReflectionProperty */
				foreach( $class->getProperties() as $attribute )
				{
					$attributes[] = $attribute;
				}
			}

			$this->setAttributes( new AttributesCollection( $attributes ) );
		}

		return $this->attributes;
	}

	/**
	 *
	 * @param AttributesCollection $attributes
	 */
	public function setAttributes( AttributesCollection $attributes )
	{
		$this->attributes = $attributes;
		return $this;
	}

	/**
	 *
	 * @return ParameterCollection
	 */
	public function getParameters()
	{
		if( null === $this->parameters )
		{
			$parameters = [];

			/* @var $class ReflectionMethods */
			foreach( $this->getOperations() as $operation )
			{
				foreach( $operation->getParameters() as $parameter )
				{
					$parameters[] = $parameter;
				}
			}

			$this->setParameters( new ParameterCollection( $parameters ) );
		}
		return $this->parameters;
	}

	public function setParameters( ParameterCollection $parameters )
	{
		$this->parameters = $parameters;
		return $this;
	}
}