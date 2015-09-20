<?php
/**
 * SK ITCBundle SOAP WSDL tParam
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\WSDL;

class tParam extends Element
{

	/**
	 * SK ITCBundle WSDL tParam Contructor
	 *
	 * @param string $uri        	
	 */
	public function __construct(\DOMElement $element)
	{
		$this->setDOMElement($element);
	}
}