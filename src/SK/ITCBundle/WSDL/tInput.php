<?php

/**
 * SK ITCBundle SOAP WSDL tInput
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\WSDL;

class tInput extends Element
{
	const ELEMENT_NAME = 'wsdl:input';
	
	/**
	 * SK ITCBundle WSDL tInput Contructor
	 *
	 * @param string $uri        	
	 */
	public function __construct( \DOMElement $element )
	{
		$this->setDOMElement( $element );
	}
}