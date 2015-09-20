<?php
/**
 * SK ITCBundle WSDL tDocumented
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\WSDL;

class tDocumented extends Element
{

	/**
	 * SK ITCBundle WSDL tDocumented Contructor
	 *
	 * @param string $uri        	
	 */
	public function __construct(\DOMElement $element)
	{
		$this->setDOMElement($element);
	}
}