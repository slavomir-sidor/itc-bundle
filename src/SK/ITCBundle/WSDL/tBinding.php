<?php

/**
 * SK ITCBundle SOAP WSDL tBinding
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\WSDL;

class tBinding extends Element
{

	const ELEMENT_NAME = 'wsdl:binding';

	/**
	 * SK ITCBundle WSDL tBinding Contructor
	 *
	 * @param string $uri        	
	 */
	public function __construct( 
		\DOMElement $element )
	{

		$this->setDOMElement( $element );
	
	}

}