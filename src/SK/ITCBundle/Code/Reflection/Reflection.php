<?php

namespace SK\ITCBundle\Code\Reflection;

use Monolog\Logger;
use TokenReflection\Broker;

class Reflection
{

	/**
	 * SK ITCBundle Code Generator Class Reflection
	 *
	 * @var ReflectionClass[]
	 */
	protected $classReflections;

	/**
	 * SK ITCBundle Code Generator Reflection Operations
	 *
	 * @var ReflectionMethod[]
	 */
	protected $operationsReflections;

	/**
	 * SK ITCBundle Code Generator Finder
	 *
	 * @var Finder[]
	 */
	protected $finders = array();

	/**
	 * SK ITCBundle Code Generator Finder
	 *
	 * @var ReflectionFile[]
	 */
	protected $fileRelections;

	/**
	 * SK ITCBundle Code Generator Broker
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
	 * @return the ReflectionClass[]
	 */
	public function getClassReflections()
	{

		return $this->classReflections;

	}

	/**
	 *
	 * @param
	 *        	$classReflections
	 */
	public function setClassReflections(
		$classReflections )
	{

		$this->classReflections = $classReflections;
		return $this;

	}

	/**
	 *
	 * @return the ReflectionMethod[]
	 */
	public function getOperationsReflections()
	{

		return $this->operationsReflections;

	}

	/**
	 *
	 * @param
	 *        	$operationsReflections
	 */
	public function setOperationsReflections(
		$operationsReflections )
	{

		$this->operationsReflections = $operationsReflections;
		return $this;

	}

	/**
	 *
	 * @return the Finder[]
	 */
	public function getFinders()
	{

		return $this->finders;

	}

	/**
	 *
	 * @param
	 *        	$finders
	 */
	public function setFinders(
		$finders )
	{

		$this->finders = $finders;
		return $this;

	}

	/**
	 *
	 * @return the ReflectionFile[]
	 */
	public function getFileRelections()
	{

		return $this->fileRelections;

	}

	/**
	 *
	 * @param
	 *        	$fileRelections
	 */
	public function setFileRelections(
		$fileRelections )
	{

		$this->fileRelections = $fileRelections;
		return $this;

	}

	/**
	 *
	 * @return the Broker
	 */
	public function getBroker()
	{

		return $this->broker;

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

	public function getLogger()
	{

		return $this->logger;

	}

	public function setLogger(
		Logger $logger )
	{

		$this->logger = $logger;
		return $this;

	}

}