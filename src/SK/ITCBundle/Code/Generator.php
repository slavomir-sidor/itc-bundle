<?php
namespace SK\ITCBundle\Code;

use Monolog\Logger;
use TokenReflection\Broker;
use Symfony\Component\Finder\Finder;
use TokenReflection\Broker\Backend;
use TokenReflection\ReflectionFile;
use TokenReflection\ReflectionNamespace;
use TokenReflection\Php\ReflectionClass;
use TokenReflection\Php\ReflectionProperty;
use TokenReflection\Php\ReflectionMethod;
use TokenReflection\Php\ReflectionParameter;
use SK\ITCBundle\Code\Reflection\Settings;
use SK\ITCBundle\Code\Reflection\Collection\PackageCollection;
use SK\ITCBundle\Code\Reflection\Collection\FileCollection;
use SK\ITCBundle\Code\Reflection\Collection\ClassCollection;
use SK\ITCBundle\Code\Reflection\Collection\OperationCollection;
use SK\ITCBundle\Code\Reflection\Collection\ParameterCollection;
use SK\ITCBundle\Code\Reflection\Collection\AttributesCollection;

class Generator extends Reflection
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
	 *
	 * @var Settings
	 */
	protected $settings;

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
	protected function getBroker()
	{
		if( null === $this->broker )
		{
			$broker = new Broker( new Broker\Backend\Memory() );
			$this->setBroker( $broker );
		}

		return $this->broker;
	}

	/**
	 *
	 * @return ClassCollection
	 */
	public function getClasses( Settings $settings = NULL )
	{
		if( NULL !== $settings )
		{
			$this->setSettings( $settings );
		}

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

			$settings = $this->getSettings();

			$classes = $classes->filter(
				function ( $class ) use ($settings )
				{
					if( NULL !== $settings->getClassName() )
					{
						return ( bool ) preg_match( sprintf( "/%s/", preg_quote( $settings->getClassName() ) ), $class->getName() );
					}

					return true;
				} );

			$classes = $classes->filter(
				function ( $class ) use ($settings )
				{

					if( NULL !== $settings->getIsAbstractClass() )
					{
						return ( $settings->getIsAbstractClass() == $class->isAbstract() );
					}

					return true;
				} );

			$classes = $classes->filter(
				function ( $class ) use ($settings )
				{
					if( NULL !== $settings->getIsFinal() )
					{
						return ( $settings->getIsFinal() == $class->isFinal() );
					}

					return true;
				} );

			$classes = $classes->filter(
				function ( $class ) use ($settings )
				{
					if( NULL !== $settings->getIsInterface() )
					{
						return ( $settings->getIsInterface() == $class->isInterface() );
					}

					return true;
				} );

			$classes = $classes->filter(
				function ( $class ) use ($settings )
				{
					if( NULL !== $settings->getIsTrait() )
					{
						return ( $settings->getIsTrait() == $class->isTrait() );
					}

					return true;
				} );

			$classes = $classes->filter(
				function ( $class ) use ($settings )
				{
					if( count( $settings->getParentClass() ) > 0 )
					{
						foreach( $settings->getParentClass() as $parentClass )
						{
							if( in_array( $parentClass, $class->getParentClassNameList() ) )
							{
								return true;
							}
						}

						return false;
					}

					return true;
				} );

			$classes = $classes->filter(
				function ( $class ) use ($settings )
				{
					if( count( $settings->getImplementsInterface() ) > 0 )
					{
						foreach( $settings->getImplementsInterface() as $interface )
						{
							if( in_array( $interface, $class->getInterfaceNames() ) )
							{
								return true;
							}
						}

						return false;
					}

					return true;
				} );

			$this->setClasses( $classes );
		}
		return $this->classes;
	}

	/**
	 *
	 * @param ClassCollection $classes
	 */
	protected function setClasses( ClassCollection $classes )
	{
		$this->classes = $classes;
		return $this;
	}

	/**
	 *
	 * @return OperationCollection
	 */
	public function getOperations( Settings $settings = NULL )
	{
		if( NULL !== $settings )
		{
			$this->setSettings( $settings );
		}

		if( null === $this->operations )
		{
			$operations = new OperationCollection();

			/* @var $class ReflectionClass */
			foreach( $this->getClasses() as $class )
			{
				/* @var $operation ReflectionMethod */
				foreach( $class->getMethods() as $operation )
				{
					$operations->set( $class->getName() . $operation->getName(), $operation );
				}
			}

			$settings = $this->getSettings();

			$operations = $operations->filter(
				function ( $operation ) use ($settings )
				{
					if( NULL !== $settings->getOperationName() )
					{
						return ( bool ) preg_match( sprintf( "/%s/", preg_quote( $settings->getOperationName() ) ), $operation->getName() );
					}

					return true;
				} );
			$operations = $operations->filter(
				function ( $operation ) use ($settings )
				{
					if( NULL !== $settings->getIsAbstractOperation() )
					{
						return ( $settings->getIsAbstractOperation() == $operation->isAbstract() );
					}
					return true;
				} );

			$operations = $operations->filter(
				function ( $operation ) use ($settings )
				{
					if( NULL !== $settings->getIsPrivate() )
					{
						return ( $settings->getIsPrivate() == $operation->isPrivate() );
					}

					return true;
				} );

			$operations = $operations->filter(
				function ( $operation ) use ($settings )
				{
					if( NULL !== $settings->getIsProtected() )
					{
						return ( $settings->getIsProtected() == $operation->isProtected() );
					}
					return true;
				} );

			$operations = $operations->filter(
				function ( $operation ) use ($settings )
				{
					if( NULL !== $settings->getIsPublic() )
					{
						return ( $settings->getIsPublic() == $operation->isPublic() );
					}
					return true;
				} );

			$operations = $operations->filter(
				function ( $operation ) use ($settings )
				{
					if( NULL !== $settings->getIsStatic() )
					{
						return ( $settings->getIsStatic() == $operation->isStatic() );
					}
					return true;
				} );

			$operations = $operations->filter(
				function ( $operation ) use ($settings )
				{
					if( NULL !== $settings->getIsStatic() )
					{
						return ( $settings->getIsStatic() == $operation->isStatic() );
					}

					return true;
				} );

			$this->setOperations( $operations );
		}

		return $this->operations;
	}

	/**
	 *
	 * @param OperationCollection $operationsReflections
	 */
	protected function setOperations( OperationCollection $operations )
	{
		$this->operations = $operations;
		return $this;
	}

	/**
	 *
	 * @return Finder
	 */
	protected function getFinder()
	{
		if( null === $this->finder )
		{
			$finder = new Finder();
			$settings = $this->getSettings();

			foreach( $settings->getSrc() as $source )
			{
				if( is_dir( $source ) )
				{
					$finder->in( $source );
				}

				if( is_file( $source ) )
				{
					$finder->append( array(
						$source
					) );
				}
			}

			if( true === $settings->getFollowLinks() )
			{
				$finder->followLinks();
			}

			$finder->ignoreDotFiles( $settings->getIgnoreDotFiles() );
			$finder->name( $settings->getFileSuffix() );
			$finder->exclude( $settings->getExclude() );

			$this->setFinder( $finder );
		}

		return $this->finder;
	}

	/**
	 *
	 * @param Finder $finder
	 * @return Reflection
	 */
	protected function setFinder( Finder $finder )
	{
		$this->finder = $finder;
		return $this;
	}

	/**
	 *
	 * @return FileCollection
	 */
	public function getFiles( Settings $settings = NULL )
	{
		if( NULL !== $settings )
		{
			$this->setSettings( $settings );
		}

		if( null === $this->files )
		{
			$files = new FileCollection();
			$finder = $this->getFinder();

			foreach( $finder->files() as $fileName )
			{
				try
				{
					/* @var $fileReflection ReflectionFile */
					$file = $this->getBroker()->processFile( $fileName, true );
					$files->set( $file->getName(), $file );
				}
				catch( \Exception $exception )
				{
					$this->getLogger()->log( Logger::NOTICE, $exception->getMessage() );
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
	protected function setFiles( FileCollection $files )
	{
		$this->files = $files;
		return $this;
	}

	/**
	 *
	 * @param Broker $broker
	 */
	protected function setBroker( Broker $broker )
	{
		$this->broker = $broker;
		return $this;
	}

	/**
	 *
	 * @return Logger
	 */
	protected function getLogger()
	{
		return $this->logger;
	}

	/**
	 *
	 * @param Logger $logger
	 * @return Reflection
	 */
	protected function setLogger( Logger $logger )
	{
		$this->logger = $logger;
		return $this;
	}

	/**
	 *
	 * @return PackageCollection
	 */
	public function getPackages( Settings $settings = NULL )
	{
		if( NULL !== $settings )
		{
			$this->setSettings( $settings );
		}

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

	protected function setPackages( PackageCollection $packages )
	{
		$this->packages = $packages;
		return $this;
	}

	/**
	 *
	 * @return AttributesCollection
	 */
	public function getAttributes( Settings $settings = NULL )
	{
		if( NULL !== $settings )
		{
			$this->setSettings( $settings );
		}

		if( null === $this->attributes )
		{
			$attributes = new AttributesCollection();

			/* @var $class ReflectionClass */
			foreach( $this->getClasses() as $class )
			{
				/* @var $attribute ReflectionProperty */
				foreach( $class->getProperties() as $attribute )
				{
					$attributes->set( $class->getName() . $attribute->getName(), $attribute );
				}
			}

			$settings = $this->getSettings();

			$attributes = $attributes->filter(

				function ( $attribute ) use ($settings )
				{
					if( NULL !== $settings->getAttributeName() )
					{
						return ( bool ) preg_match( sprintf( "/%s/", $settings->getAttributeName() ), $attribute->getName() );
					}

					return true;
				} );

			$attributes = $attributes->filter(

				function ( $attribute ) use ($settings )
				{
					if( NULL !== $settings->getIsPrivate() )
					{
						return ( $attribute->isPrivate() === $settings->getIsPrivate() );
					}

					return true;
				} );

			$attributes = $attributes->filter(

				function ( $attribute ) use ($settings )
				{
					if( NULL !== $settings->getIsProtected() )
					{
						return ( $attribute->isProtected() === $settings->getIsProtected() );
					}

					return true;
				} );

			$attributes = $attributes->filter(

				function ( $attribute ) use ($settings )
				{
					if( NULL !== $settings->getIsPrivate() )
					{
						return ( $attribute->isPrivate() === $settings->getIsPrivate() );
					}

					return true;
				} );

			$this->setAttributes( $attributes );
		}

		return $this->attributes;
	}

	/**
	 *
	 * @param AttributesCollection $attributes
	 */
	protected function setAttributes( AttributesCollection $attributes )
	{
		$this->attributes = $attributes;
		return $this;
	}

	/**
	 *
	 * @return ParameterCollection
	 */
	public function getParameters( Settings $settings = NULL )
	{
		if( NULL !== $settings )
		{
			$this->setSettings( $settings );
		}

		if( null === $this->parameters )
		{
			$parameters = new ParameterCollection();

			/* @var $operation ReflectionMethods */
			foreach( $this->getOperations() as $key => $operation )
			{
				/* @var $parameter ReflectionParameter */
				foreach( $operation->getParameters() as $parameter )
				{
					$parameters->set( $key . $parameter->getName(), $parameter );
				}
			}

			$settings = $this->getSettings();

			$parameters = $parameters->filter(

				function ( $parameter ) use ($settings )
				{
					if( NULL !== $settings->getParameterName() )
					{
						return ( bool ) preg_match( sprintf( "/%s/", $settings->getParameterName() ), $parameter->getName() );
					}

					return true;
				} );

			$this->setParameters( $parameters );
		}
		return $this->parameters;
	}

	/**
	 *
	 * @param ParameterCollection $parameters
	 */
	protected function setParameters( ParameterCollection $parameters )
	{
		$this->parameters = $parameters;
		return $this;
	}

	/**
	 *
	 * @return Settings
	 */
	public function getSettings()
	{
		return $this->settings;
	}

	/**
	 *
	 * @param Settings $settings
	 */
	public function setSettings( Settings $settings )
	{
		$this->settings = $settings;
		return $this;
	}
}