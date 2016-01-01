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
use SK\ITCBundle\Code\Reflection\Collection\PropertyCollection;
use SK\ITCBundle\Code\Reflection\Collection\ParameterCollection;
use Symfony\Component\DependencyInjection\Variable;

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
	protected $properties;

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
	public function __construct(
		Logger $logger )
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
	 * @param string $className
	 * @return ReflectionClass
	 */
	public function getClass(
		$className )
	{

		return $this->getClasses()
			->get( $className );

	}

	/**
	 *
	 * @return FileCollection
	 *
	 * @todo get rid of broker
	 */
	public function getClasses()
	{

		if( null === $this->classes )
		{
			$classes = new FileCollection();

			foreach( $this->getFiles() as $file )
			{

				foreach( $file->getNamespaces() as $namespace )
				{
					$classes->addMap( $namespace->getClasses() );
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
	public function setClasses(
		ClassCollection $classes )
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
			$operations = new OperationCollection();
			foreach( $this->getClasses() as $class )
			{
				$operations->addMap( $class->getMethods() );
			}
			$this->setOperations( $operations );
		}
		return $this->operations;

	}

	/**
	 *
	 * @param OperationCollection $operationsReflections
	 */
	public function setOperations(
		OperationCollection $operations )
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
	public function setFinder(
		Finder $finder )
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
	public function getFile(
		$filename )
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

					$files->set($file->getName(), $file);
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
	public function setFiles(
		FileCollection $files )
	{

		$this->files = $files;
		return $this;

	}

	/**
	 *
	 * @param Broker $broker
	 */
	public function setBroker(
		Broker $broker )
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
	public function setLogger(
		Logger $logger )
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
			$files = $this->getFiles();

			foreach( $files as $file )
			{
				$packages->addMap( $file->getNamespaces() );
			}

			$this->setPackages( $packages );
		}
		return $this->packages;

	}

	public function setPackages(
		PackageCollection $packages )
	{

		$this->packages = $packages;
		return $this;

	}

	/**
	 *
	 * @return PropertyCollection
	 */
	public function getProperties()
	{

		if( null === $this->properties )
		{
			$properties = new PropertyCollection();
			foreach( $this->getClasses() as $class )
			{
				$properties->addMap( $class->getProperties() );
			}
			$this->setProperties( $properties );
		}
		return $this->properties;

	}

	public function setProperties(
		PropertyCollection $properties )
	{

		$this->properties = $properties;
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
			$parameters = new ParameterCollection();

			foreach( $this->getOperations() as $operation )
			{
				$parameters->addMap( $operation->getParameters() );
			}
			$this->setParameters( $parameters );
		}
		return $this->parameters;

	}

	public function setParameters(
		ParameterCollection $parameters )
	{

		$this->parameters = $parameters;
		return $this;

	}

}