<?php

/**
 * SK ITCBundle WSDL tPart
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\WSDL;

class tPart extends tExtensibleAttributesDocumented
{
	
	/**
	 * SK ITCBundle WSDL tMessage Element Name
	 *
	 * @var string
	 */
	const ELEMENT_NAME = 'wsdl:part';
	
	/**
	 * SK ITCBundle WSDL tPart Contructor
	 *
	 * @param string $uri        	
	 */
	public function __construct( \DOMElement $element )
	{
		$this->setDOMElement( $element );
	}
}