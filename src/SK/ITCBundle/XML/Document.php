<?php

namespace SK\ITCBundle\XML;

use \DOMDocument as PHPDOMDocument;
use \DOMXPath as PHPDOMXpath;

/**
 * SK ITCBundle XML Document
 *
 * @license GPL GNU
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
class Document extends PHPDOMDocument
{
	
	/**
	 * SK ITCBundle XML Document XPath
	 *
	 * @var PHPDOMXpath
	 */
	protected $xpath;
	
	/**
	 * SK ITCBundle XML Document Contructor
	 *
	 * @param string $uri        	
	 */
	public function __construct( $uri )
	{
		$this->load( $uri );
	}
	
	/**
	 * Gets SK ITCBundle XML Document XPath
	 *
	 * @return PHPDOMXpath
	 */
	protected function getXpath()
	{
		if( null === $this->xpath )
		{
			$this->setXpath( new PHPDOMXpath( $this ) );
		}
		return $this->xpath;
	}
	
	/**
	 * Sets SK ITCBundle XML Document XPath
	 *
	 * @param PHPDOMXpath $xpath        	
	 * @return \SK\ITCBundle\SOAP\Document
	 */
	protected function setXpath( PHPDOMXpath $xpath )
	{
		$this->xpath = $xpath;
		return $this;
	}
}