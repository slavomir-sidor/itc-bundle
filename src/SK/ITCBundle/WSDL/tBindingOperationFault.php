<?php

/**
 * SK ITCBundle WSDL Binding Operation Fault
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\WSDL;

class tBindingOperationFault extends Element
{

	/**
	 * SK ITCBundle WSDL tBindingOperationFault Contructor
	 *
	 * @param string $uri        	
	 */
	public function __construct( 
		\DOMElement $element )
	{

		$this->setDOMElement( $element );
	
	}

}