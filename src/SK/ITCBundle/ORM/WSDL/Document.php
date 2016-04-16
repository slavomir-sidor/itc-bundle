<?php

/**
 * SK ITCBundle SOAP WSDL
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\ORM\WSDL;

use SK\ITCBundle\ORM\XMLSchema\Document as XMLSchemaDocument;
use \DOMElement as PHPDOMElement;

class Document extends XMLSchemaDocument
{

	/**
	 * SK ITCBundle SOAP WSDL
	 *
	 * @var tDefinitions
	 */
	protected $definitions;

	/**
	 *
	 * @param PHPDOMElement $element        	
	 */
	public function __construct( 
		$uri )
	{

		parent::__construct( $uri );
		
		foreach( $this->childNodes as $childNode )
		{
			if( $childNode instanceof PHPDOMElement )
			{
				switch( $childNode->tagName )
				{
					case tDefinitions::ELEMENT_NAME:
						$this->definitions = new tDefinitions( $childNode );
						break;
				}
			}
		}
	
	}

	/**
	 * SK ITCBundle SOAP WSDL Definitions
	 *
	 * @return tDefinitions
	 */
	public function getDefinitions()
	{

		return $this->definitions;
	
	}

	/**
	 *
	 * @param tDefinitions $definitions        	
	 */
	public function setDefinitions( 
		tDefinitions $definitions )
	{

		$this->definitions = $definitions;
		return $this;
	
	}

}