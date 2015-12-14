<?php

/**
 * SK ITCBundle SOAP WSDL tMessage
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\WSDL;

class tMessage extends Element
{
	
	/**
	 * SK ITCBundle WSDL tMessage Element Name
	 *
	 * @var string
	 */
	const ELEMENT_NAME = 'wsdl:message';
	
	/**
	 * SK ITCBundle WSDL tMessage part
	 *
	 * @var tPart[]
	 */
	protected $part;
	
	/**
	 * SK ITCBundle WSDL tMessage Contructor
	 *
	 * @param \DOMElement $domElement        	
	 */
	public function __construct( \DOMElement $domElement )
	{
		parent::__construct( $domElement );
		foreach( $domElement->childNodes as $childNode )
		{
			if( $childNode instanceof \DOMElement )
			{
				switch( $childNode->tagName )
				{
					case tPart::ELEMENT_NAME:
						$this->part[] = new tPart( $childNode );
						break;
				}
			}
		}
	}
}