<?php

/**
 * SK ITCBundle WSDL tDocumentation
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\WSDL;

class tDocumentation extends Element
{

	const ELEMENT_NAME = 'wsdl:documentation';

	/**
	 * SK ITCBundle WSDL tDocumented Contructor
	 *
	 * @param string $uri        	
	 */
	public function __construct( 
		\DOMElement $element )
	{

		$this->setDOMElement( $element );
	
	}

}