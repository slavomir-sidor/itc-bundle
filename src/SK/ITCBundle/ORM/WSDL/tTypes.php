<?php

/**
 * SK ITCBundle SOAP WSDL Types
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\WSDL;

use SK\ITCBundle\XMLSchema\Schema;

class tTypes extends tExtensibleDocumented
{

	const ELEMENT_NAME = 'wsdl:types';

	/**
	 * SK ITCBundle SOAP WSDL Types Schema
	 *
	 * @var Schema
	 */
	protected $schema;

	/**
	 * SK ITCBundle XML Document Contructor
	 *
	 * @param string $uri        	
	 */
	public function __construct( 
		\DOMElement $element )
	{

		$this->setDOMElement( $element );
		
		foreach( $element->childNodes as $childNode )
		{
			if( $childNode instanceof \DOMElement )
			{
				switch( $childNode->tagName )
				{
					case Schema::ELEMENT_NAME:
						$this->setSchema( new Schema( $childNode ) );
						break;
				}
			}
		}
	
	}

	/**
	 * Gets SK ITCBundle SOAP WSDL Types Schema
	 *
	 * @return Schema
	 */
	public function getSchema()
	{

		return $this->schema;
	
	}

	/**
	 * Sets SK ITCBundle SOAP WSDL Types Schema
	 *
	 * @param Schema $schema        	
	 */
	public function setSchema( 
		Schema $schema )
	{

		$this->schema = $schema;
		return $this;
	
	}

}