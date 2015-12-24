<?php

/**
 * SK ITC Bundle Code Bundle Reflection Namespace
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Code\Reflection;

use Zend\Code\Reflection\ClassReflection;

class BundleNamespace extends \RecursiveArrayIterator
{

	/**
	 * SK ITC Bundle Code Bundle Reflection Namespace Class
	 * Reflections
	 *
	 * @var multitype:\Zend\Code\Reflection\ClassReflection
	 */
	protected $classReflections;

	/**
	 * SK ITC Bundle Code Bundle Reflection Namespace Name
	 *
	 * @var string
	 */
	protected $name;

	/**
	 * SK ITC Bundle Code Bundle Reflection Namespace ShortName
	 *
	 * @var string
	 */
	protected $shortName;

	/**
	 * SK ITC Bundle Code Bundle Reflection Namespace Parent Bundle Namespace
	 *
	 * @var BundleNamespace
	 */
	protected $parent;

	/**
	 * Gets SK ITC Bundle Code Bundle Reflection Namespace Class
	 * Reflection
	 *
	 * @param string $className        	
	 * @return \Zend\Code\Reflection\ClassReflection
	 */
	public function getClassReflection( 
		$className )
	{

		$classReflections = $this->getClassReflections();
		return array_key_exists( $className, $classReflections ) ? $classReflections[ $className ] : NULL;
	
	}

	/**
	 * Gets SK ITC Bundle Code Bundle Reflection Namespace Class
	 * Reflections
	 *
	 * @return multitype:\Zend\Code\Reflection\ClassReflection
	 */
	public function getClassReflections()
	{

		return $this->classReflections;
	
	}

	/**
	 * Sets SK ITC Bundle Code Bundle Reflection Namespace Class
	 * Reflections
	 *
	 * @param multitype:\Zend\Code\Reflection\ClassReflection $classReflections        	
	 * @return \SK\ITCBundle\Code\Reflection\BundleNamespace
	 */
	public function setClassReflections( 
		$classReflections )
	{

		foreach( $classReflections as $classReflection )
		{
			$this->getNamespace( $classReflection->getNamespaceName() )
				->addClassReflection( $classReflection );
		}
		
		return $this;
	
	}

	/**
	 * Adds SK ITC Bundle Code Bundle Reflection Namespace Class
	 * Reflection
	 *
	 * @param ClassReflection $classReflection
	 *        	SK ITC Bundle Code Bundle Reflection Namespace Class
	 *        	Reflection
	 * @return \SK\ITCBundle\Code\Reflection\BundleNamespace
	 */
	public function addClassReflection( 
		ClassReflection $classReflection )
	{

		$classShortName = $classReflection->getShortName();
		$this->classReflections[ $classShortName ] = $classReflection;
		return $this;
	
	}

	/**
	 * Gets SK ITC Bundle Code Bundle Namespace Reflection
	 *
	 * @param string $namespaceName        	
	 * @return \SK\ITCBundle\Code\Reflection\BundleNamespace
	 */
	public function getNamespace( 
		$namespaceName )
	{

		$namespaceKeys = explode( "\\", $namespaceName );
		$namespace = $this;
		$namespacePath = array();
		
		while( count( $namespaceKeys ) > 0 )
		{
			$shortName = array_shift( $namespaceKeys );
			$namespacePath[] = $shortName;
			
			if( FALSE === $namespace->offsetExists( $shortName ) )
			{
				$childNamespace = new BundleNamespace( array() );
				$childNamespace->setName( implode( "\\", $namespacePath ) );
				$childNamespace->setShortName( $shortName );
				$childNamespace->setParent( $this );
				$namespace->offsetSet( $shortName, $childNamespace );
			}
			$namespace = $namespace->offsetGet( $shortName );
		}
		
		return $namespace;
	
	}

	/**
	 * Gets SK ITC Bundle Code Bundle Reflection Namespace Name
	 *
	 * @return string
	 */
	public function getName()
	{

		return $this->name;
	
	}

	/**
	 * Sets SK ITC Bundle Code Bundle Reflection Namespace Name
	 *
	 * @param string $name
	 *        	SK ITC Bundle Code Bundle Reflection Namespace Name
	 * @return \SK\ITCBundle\Code\Reflection\BundleNamespace
	 */
	public function setName( 
		$name )
	{

		$this->name = $name;
		return $this;
	
	}

	/**
	 * Gets SK ITC Bundle Code Bundle Reflection Namespace Short Name
	 *
	 * @return string
	 */
	public function getShortName()
	{

		return $this->shortName;
	
	}

	/**
	 * Sets SK ITC Bundle Code Bundle Reflection Namespace Short Name
	 *
	 * @param string $shortName        	
	 * @return \SK\ITCBundle\Code\Reflection\BundleNamespace
	 */
	public function setShortName( 
		$shortName )
	{

		$this->shortName = $shortName;
		return $this;
	
	}

	/**
	 * Gets SK ITC Bundle Code Bundle Reflection Namespace Parent Bundle
	 * Namespace
	 *
	 * @return \SK\ITCBundle\Code\Reflection\BundleNamespace
	 */
	public function getParent()
	{

		return $this->parent;
	
	}

	/**
	 * Sets SK ITC Bundle Code Bundle Reflection Namespace Parent Bundle
	 * Namespace
	 *
	 * @param BundleNamespace $parent
	 *        	SK ITC Bundle Code Bundle Reflection Namespace Parent Bundle
	 *        	Namespace
	 * @return \SK\ITCBundle\Code\Reflection\BundleNamespace
	 */
	public function setParent( 
		BundleNamespace $parent )
	{

		$this->parent = $parent;
		return $this;
	
	}

}