<?php

/**
 * SK ITCBundle WSDL tService
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\WSDL;

class tService extends Element
{

	const ELEMENT_NAME = 'wsdl:service';

	/**
	 * SK ITCBundle WSDL tService Contructor
	 *
	 * @param string $uri        	
	 */
	public function __construct( 
		\DOMElement $element )
	{

		$this->setDOMElement( $element );
	
	}

}