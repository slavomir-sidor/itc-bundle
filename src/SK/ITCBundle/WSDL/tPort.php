<?php

/**
 * SK ITCBundle WSDL tPort
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\WSDL;

class tPort extends Element
{
	
	/**
	 * SK ITCBundle WSDL tPort Element Name
	 *
	 * @var string
	 */
	const ELEMENT_NAME = 'wsdl:port';
	
	/**
	 * SK ITCBundle WSDL tPort Contructor
	 *
	 * @param string $uri        	
	 */
	public function __construct( \DOMElement $element )
	{
		$this->setDOMElement( $element );
	}
}