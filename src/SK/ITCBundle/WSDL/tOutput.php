<?php

/**
 * SK ITCBundle WSDL tOutput
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\WSDL;

class tOutput extends Element
{
	const ELEMENT_NAME = 'wsdl:output';
	
	/**
	 * SK ITCBundle WSDL tOutput Contructor
	 *
	 * @param string $uri        	
	 */
	public function __construct( \DOMElement $element )
	{
		$this->setDOMElement( $element );
	}
}