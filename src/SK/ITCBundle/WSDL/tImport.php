<?php
/**
 * SK ITCBundle SOAP WSDL tImport
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\WSDL;

class tImport extends Element
{

	const ELEMENT_NAME = 'wsdl:import';

	/**
	 * SK ITCBundle WSDL tImport Contructor
	 *
	 * @param string $uri        	
	 */
	public function __construct(\DOMElement $element)
	{
		$this->setDOMElement($element);
	}
}