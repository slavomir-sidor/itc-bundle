<?php

/**
 * SK ITCBundle SOAP WSDL Port Type
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\WSDL;

class tPortType extends tExtensibleAttributesDocumented
{

	const ELEMENT_NAME = 'wsdl:portType';

	/**
	 * SK ITCBundle SOAP WSDL Port Type Operation
	 *
	 * @var tOperation[]
	 */
	protected $operation;

	/**
	 * SK ITCBundle XML Document Contructor
	 *
	 * @param string $uri        	
	 */
	public function __construct( 
		\DOMElement $element )
	{

		$this->setDOMElement( $element );
		
		foreach( $element->childNodes as $childNode )
		{
			if( $childNode instanceof \DOMElement )
			{
				
				switch( $childNode->tagName )
				{
					case tOperation::ELEMENT_NAME:
						$this->operation[] = new tOperation( $childNode );
						break;
				}
			}
		}
	
	}

}