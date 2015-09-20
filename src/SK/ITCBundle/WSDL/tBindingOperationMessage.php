<?php
/**
 * SK ITCBundle WSDL Binding Operation Message
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\WSDL;

class tBindingOperationMessage extends Element
{

	/**
	 * SK ITCBundle WSDL tBindingOperationMessage Contructor
	 *
	 * @param string $uri        	
	 */
	public function __construct(\DOMElement $element)
	{
		$this->setDOMElement($element);
	}
}