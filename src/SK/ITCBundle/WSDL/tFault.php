<?php
/**
 * SK ITCBundle SOAP WSDL Fault
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\WSDL;

class tFault extends Element
{

	const ELEMENT_NAME = 'wsdl:fault';

	/**
	 * SK ITCBundle WSDL tFault Contructor
	 *
	 * @param string $uri        	
	 */
	public function __construct(\DOMElement $element)
	{
		$this->setDOMElement($element);
	}
}