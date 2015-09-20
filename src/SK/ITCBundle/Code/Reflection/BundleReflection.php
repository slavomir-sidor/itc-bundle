<?php
/**
 * SK ITC Bundle Code Bundle Reflection
 * 
 * @licence GNU GPL
 *  
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Code\Reflection;

use Zend\Code\Scanner\DirectoryScanner;
use Symfony\Component\HttpKernel\Bundle\Bundle;
use Zend\Code\Scanner\AggregateDirectoryScanner;
use Zend\Code\Scanner\FileScanner;
use Zend\Code\Reflection\ClassReflection;
use Zend\Code\Reflection\FileReflection;

class BundleReflection
{

	/**
	 * SK ITC Bundle Code Bundle Reflection Symfony Bundle
	 *
	 * @var Bundle
	 */
	protected $bundle;

	/**
	 * SK ITC Bundle Code Bundle Reflection Namespace
	 *
	 * @var BundleNamespace
	 */
	protected $namespace;

	/**
	 * SK ITC Bundle Code Bundle Reflection Resources
	 *
	 * @var BundleResources
	 */
	protected $resources;

	/**
	 * SK ITC Bundle Code Bundle Reflection Directory Scanner
	 *
	 * @var DirectoryScanner
	 */
	protected $directoryScanner;

	/**
	 * SK ITC Bundle Code Bundle Reflection File Scanners
	 *
	 * @var FileScanner[]
	 */
	protected $fileScanners;

	/**
	 * SK ITC Bundle Code Bundle Reflection Class Reflection
	 *
	 * @var ClassReflection[]
	 */
	protected $classReflections;

	/**
	 * SK ITC Bundle Code Bundle Reflection Constructor
	 *
	 * @param Bundle $bundle
	 *        	SK ITC Bundle Code Bundle Reflection Bundle
	 */
	public function __construct(Bundle $bundle)
	{
		$this->setBundle($bundle);
	}

	/**
	 * Gets SK ITC Bundle Code Bundle Reflection Name
	 *
	 * @return string
	 */
	public function getName()
	{
		return $this->getBundle()->getName();
	}

	/**
	 * Gets SK ITC Bundle Code Bundle Reflection Namespace
	 *
	 * @return \SK\ITCBundle\Code\Reflection\BundleNamespace
	 */
	public function getNamespace($namespaceName = NULL)
	{
		if (NULL === $this->namespace)
		{
			$namespace = new BundleNamespace(array());
			$namespace->setClassReflections($this->getClassReflections());
			$this->setNamespace($namespace);
		}
		
		if (NULL !== $namespaceName)
		{
			return $this->namespace->getNamespace($namespaceName);
		}
		return $this->namespace;
	}

	/**
	 * Sets SK ITC Bundle Code Bundle Reflection Namespace
	 *
	 * @param BundleNamespace $namespace        	
	 * @return \SK\ITCBundle\Code\Reflection\BundleReflection
	 */
	public function setNamespace(BundleNamespace $namespace)
	{
		$this->namespace = $namespace;
		return $this;
	}

	/**
	 * Gets SK ITC Bundle Code Bundle Reflection Resources
	 *
	 * @return \SK\ITCBundle\Code\Reflection\BundleResources
	 */
	public function getResources()
	{
		return $this->resources;
	}

	/**
	 * Sets SK ITC Bundle Code Bundle Reflection Resources
	 *
	 * @param BundleResources $resources
	 *        	SK ITC Bundle Code Bundle Reflection Resources
	 * @return \SK\ITCBundle\Code\Reflection\BundleReflection
	 */
	public function setResources(BundleResources $resources)
	{
		$this->resources = $resources;
		return $this;
	}

	/**
	 * Gets SK ITC Bundle Code Bundle Reflection Directory Scanner
	 *
	 * @return \Zend\Code\Scanner\DirectoryScanner
	 */
	public function getDirectoryScanner()
	{
		if (NULL === $this->directoryScanner)
		{
			try
			{
				$directoryScannerPath = $this->getBundle()->getPath();
				$directoryScanner = new AggregateDirectoryScanner($directoryScannerPath);
				$this->setDirectoryScanner($directoryScanner);
			}
			catch (\Exception $e)
			{}
			unset($directoryScannerPath);
		}
		return $this->directoryScanner;
	}

	/**
	 * Sets SK ITC Bundle Code Bundle Reflection Directory Scanner
	 *
	 * @param DirectoryScanner $directoryScanner        	
	 * @return \SK\ITCBundle\Code\Reflection\BundleReflection
	 */
	public function setDirectoryScanner(DirectoryScanner $directoryScanner)
	{
		$this->directoryScanner = $directoryScanner;
		return $this;
	}

	/**
	 * Gets SK ITC Bundle Code Bundle Reflection Symfony Bundle
	 *
	 * @return \Symfony\Component\HttpKernel\Bundle\Bundle
	 */
	public function getBundle()
	{
		return $this->bundle;
	}

	/**
	 * Sets SK ITC Bundle Code Bundle Reflection Symfony Bundle
	 *
	 * @param Bundle $bundle        	
	 * @return \SK\ITCBundle\Code\Reflection\BundleReflection
	 */
	public function setBundle(Bundle $bundle)
	{
		$this->bundle = $bundle;
		return $this;
	}

	/**
	 * Gets Gets SK ITC Bundle Code Bundle Reflection
	 *
	 * @return multitype:\SK\ITCBundle\Code\Reflection\FileScanner
	 */
	public function getFileScanners()
	{
		if (NULL === $this->fileScanners)
		{
			$this->setFileScanners($this->getDirectoryScanner()
				->getFiles(TRUE));
		}
		
		return $this->fileScanners;
	}

	/**
	 * Sets SK ITC Bundle Code Bundle Reflection File Scanners
	 *
	 * @param multitype:\SK\ITCBundle\Code\Reflection\FileScanner $fileScanners        	
	 * @return \SK\ITCBundle\Code\Reflection\BundleReflection
	 */
	public function setFileScanners($fileScanners)
	{
		$this->fileScanners = $fileScanners;
		return $this;
	}

	/**
	 * Gets SK ITC Bundle Code Bundle Reflection Class Reflections
	 *
	 * @return multitype:\SK\ITCBundle\Code\Reflection\ClassReflection
	 */
	public function getClassReflections()
	{
		if (NULL === $this->classReflections)
		{
			$classesReflections = array();
			
			try
			{
				$fileScanners = $this->getFileScanners();
				
				foreach ($fileScanners as $fileScanner)
				{
					try
					{
						$file = $fileScanner->getFile();
						$fileReflection = new FileReflection($file, TRUE);
						$classReflections = $fileReflection->getClasses();
						foreach ($classReflections as $classReflection)
						{
							$classesReflections[] = $classReflection;
						}
					}
					catch (Exception $e)
					{}
				}
			}
			catch (Exception $e)
			{}
			
			$this->setClassReflections($classesReflections);
		}
		
		return $this->classReflections;
	}

	/**
	 * Sets SK ITC Bundle Code Bundle Reflection Class Reflections
	 *
	 * @param multitype:\SK\ITCBundle\Code\Reflection\ClassReflection $classReflections        	
	 * @return \SK\ITCBundle\Code\Reflection\BundleReflection
	 */
	public function setClassReflections($classReflections)
	{
		$this->classReflections = $classReflections;
		return $this;
	}
}