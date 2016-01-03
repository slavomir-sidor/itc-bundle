<?php
namespace SK\ITCBundle\Code\Reflection;

class Settings
{

	/**
	 *
	 * @var Settings
	 */
	private static $instance;

	/**
	 *
	 * @var string $attributeName
	 */
	protected $attributeName;

	/**
	 *
	 * @var boolean
	 */
	protected $ignoreDotFiles;

	/**
	 *
	 * @var string
	 */
	protected $className;

	/**
	 *
	 * @var string
	 */
	protected $operationName;

	/**
	 *
	 * @var string
	 */
	protected $parameterName;

	/**
	 *
	 * @var string
	 */
	protected $accessibility;

	/**
	 *
	 * @var string
	 */
	protected $parentClass;

	/**
	 *
	 * @var string
	 */
	protected $fileSuffix;

	/**
	 *
	 * @var boolean
	 */
	protected $followLinks;

	/**
	 *
	 * @var boolean
	 */
	protected $isInterface;

	/**
	 *
	 * @var boolean
	 */
	protected $isTrait;

	/**
	 *
	 * @var boolean
	 */
	protected $isFinal;

	/**
	 *
	 * @var boolean
	 */
	protected $isAbstractClass;

	/**
	 *
	 * @var boolean
	 */
	protected $isAbstractOperation;

	/**
	 *
	 * @var boolean $isPrivate
	 */
	protected $isPrivate;

	/**
	 *
	 * @var boolean
	 */
	protected $isProtected;

	/**
	 *
	 * @var boolean
	 */
	protected $isPublic;

	/**
	 *
	 * @var boolean
	 */
	protected $isStatic;

	/**
	 *
	 * @var array
	 */
	protected $implementsInterface;

	/**
	 *
	 * @var array
	 */
	protected $exclude;

	/**
	 *
	 * @var array $src
	 */
	protected $src;

	/**
	 */
	private function __construct()
	{}

	/**
	 *
	 * @return \SK\ITCBundle\Code\Reflection\Settings
	 */
	public static function getInstance()
	{
		if( NULL === self::$instance )
		{
			self::$instance = new Settings();
		}
		return self::$instance;
	}

	/**
	 *
	 * @return string
	 */
	public function getAttributeName()
	{
		return $this->attributeName;
	}

	/**
	 *
	 * @param
	 *        	$attributeName
	 */
	public function setAttributeName( $attributeName )
	{
		$this->attributeName = $attributeName;
		return $this;
	}

	/**
	 *
	 * @return boolean
	 */
	public function getIgnoreDotFiles()
	{
		return $this->ignoreDotFiles;
	}

	/**
	 *
	 * @param
	 *        	$ignoreDotFiles
	 */
	public function setIgnoreDotFiles( $ignoreDotFiles )
	{
		$this->ignoreDotFiles = $ignoreDotFiles;
		return $this;
	}

	/**
	 *
	 * @return string
	 */
	public function getOperationName()
	{
		return $this->operationName;
	}

	/**
	 *
	 * @param
	 *        	$operationName
	 */
	public function setOperationName( $operationName )
	{
		$this->operationName = $operationName;
		return $this;
	}

	/**
	 *
	 * @return string
	 */
	public function getParameterName()
	{
		return $this->parameterName;
	}

	/**
	 *
	 * @param
	 *        	$parameterName
	 */
	public function setParameterName( $parameterName )
	{
		$this->parameterName = $parameterName;
		return $this;
	}

	/**
	 *
	 * @return string
	 */
	public function getAccessibility()
	{
		return $this->accessibility;
	}

	/**
	 *
	 * @param
	 *        	$accessibility
	 */
	public function setAccessibility( $accessibility )
	{
		$this->accessibility = $accessibility;
		return $this;
	}

	/**
	 *
	 * @return string
	 */
	public function getParentClass()
	{
		return $this->parentClass;
	}

	/**
	 *
	 * @param
	 *        	$parentClass
	 */
	public function setParentClass( $parentClass )
	{
		$this->parentClass = $parentClass;
		return $this;
	}

	/**
	 *
	 * @return string
	 */
	public function getFileSuffix()
	{
		return $this->fileSuffix;
	}

	/**
	 *
	 * @param
	 *        	$fileSuffix
	 */
	public function setFileSuffix( $fileSuffix )
	{
		$this->fileSuffix = $fileSuffix;
		return $this;
	}

	/**
	 *
	 * @return boolean
	 */
	public function getFollowLinks()
	{
		return $this->followLinks;
	}

	/**
	 *
	 * @param
	 *        	$followLinks
	 */
	public function setFollowLinks( $followLinks )
	{
		$this->followLinks = $followLinks;
		return $this;
	}

	/**
	 *
	 * @return boolean
	 */
	public function getIsInterface()
	{
		return $this->isInterface;
	}

	/**
	 *
	 * @param
	 *        	$isInterface
	 */
	public function setIsInterface( $isInterface )
	{
		$this->isInterface = $isInterface;
		return $this;
	}

	/**
	 *
	 * @return boolean
	 */
	public function getIsTrait()
	{
		return $this->isTrait;
	}

	/**
	 *
	 * @param
	 *        	$isTrait
	 */
	public function setIsTrait( $isTrait )
	{
		$this->isTrait = $isTrait;
		return $this;
	}

	/**
	 *
	 * @return boolean
	 */
	public function getIsFinal()
	{
		return $this->isFinal;
	}

	/**
	 *
	 * @param
	 *        	$isFinal
	 */
	public function setIsFinal( $isFinal )
	{
		$this->isFinal = $isFinal;
		return $this;
	}

	/**
	 *
	 * @return boolean
	 */
	public function getIsAbstractClass()
	{
		return $this->isAbstractClass;
	}

	/**
	 *
	 * @param
	 *        	$isAbstractClass
	 */
	public function setIsAbstractClass( $isAbstractClass )
	{
		$this->isAbstractClass = $isAbstractClass;
		return $this;
	}

	/**
	 *
	 * @return boolean
	 */
	public function getIsAbstractOperation()
	{
		return $this->isAbstractOperation;
	}

	/**
	 *
	 * @param
	 *        	$isAbstractOperation
	 */
	public function setIsAbstractOperation( $isAbstractOperation )
	{
		$this->isAbstractOperation = $isAbstractOperation;
		return $this;
	}

	/**
	 *
	 * @return boolean
	 */
	public function getIsPrivate()
	{
		return $this->isPrivate;
	}

	/**
	 *
	 * @param
	 *        	$isPrivate
	 */
	public function setIsPrivate( $isPrivate )
	{
		$this->isPrivate = $isPrivate;
		return $this;
	}

	/**
	 *
	 * @return boolean
	 */
	public function getIsProtected()
	{
		return $this->isProtected;
	}

	/**
	 *
	 * @param
	 *        	$isProtected
	 */
	public function setIsProtected( $isProtected )
	{
		$this->isProtected = $isProtected;
		return $this;
	}

	/**
	 *
	 * @return boolean
	 */
	public function getIsPublic()
	{
		return $this->isPublic;
	}

	/**
	 *
	 * @param
	 *        	$isPublic
	 */
	public function setIsPublic( $isPublic )
	{
		$this->isPublic = $isPublic;
		return $this;
	}

	/**
	 *
	 * @return boolean
	 */
	public function getIsStatic()
	{
		return $this->isStatic;
	}

	/**
	 *
	 * @param
	 *        	$isStatic
	 */
	public function setIsStatic( $isStatic )
	{
		$this->isStatic = $isStatic;
		return $this;
	}

	/**
	 *
	 * @return array
	 */
	public function getImplementsInterface()
	{
		return $this->implementsInterface;
	}

	/**
	 *
	 * @param array $implementsInterface
	 */
	public function setImplementsInterface( array $implementsInterface )
	{
		$this->implementsInterface = $implementsInterface;
		return $this;
	}

	/**
	 *
	 * @return array
	 */
	public function getExclude()
	{
		return $this->exclude;
	}

	/**
	 *
	 * @param array $exclude
	 */
	public function setExclude( array $exclude )
	{
		$this->exclude = $exclude;
		return $this;
	}

	/**
	 *
	 * @return array
	 */
	public function getSrc()
	{
		return $this->src;
	}

	/**
	 *
	 * @param array $src
	 */
	public function setSrc( array $src )
	{
		$this->src = $src;
		return $this;
	}

	/**
	 *
	 * @return string
	 */
	public function getClassName()
	{
		return $this->className;
	}

	/**
	 *
	 * @param
	 *        	$className
	 */
	public function setClassName( $className )
	{
		$this->className = $className;
		return $this;
	}
}