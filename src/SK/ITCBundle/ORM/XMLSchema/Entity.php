<?php

/**
 * SK ITCBundle XML Schema Entity
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\ORM\XMLSchema;

class Entity
{

	/**
	 *
	 * @var \DOMElement
	 */
	protected $domElement;

	/**
	 * SK ITCBundle XML Schema Element Contructor
	 *
	 * @param \DOMElement $domElement
	 *        	SK ITCBundle XML Document PHP DOM Element
	 */
	public function __construct( 
		\DOMElement $domElement )
	{

		$this->setDOMElement( $domElement );
	
	}

	public function __get( 
		$name )
	{

		return $this->$name;
	
	}

	public function __set( 
		$name, 
		$value )
	{

		$values = $this->$name;
		$values[] = $value;
		$this->$name = $values;
	
	}

	/**
	 *
	 * @param \DOMElement $domElement        	
	 * @return Entity
	 */
	public static function create( 
		\DOMElement $domElement )
	{

		$entityName = $domElement->tagName;
		if( $domElement->prefix != "" )
		{
			$entityName = substr( $entityName, strlen( $domElement->prefix ) + 1, strlen( $entityName ) );
		}
		$entityName = ucfirst( $entityName );
		$domElementEntityClass = sprintf( "%s\\Entity\\%sEntity", __NAMESPACE__, $entityName );
		$domElementEntity = new $domElementEntityClass( $domElement );
		
		return $domElementEntity;
	
	}

	/**
	 *
	 * @param \DOMElement $domElement        	
	 */
	public function setDOMElement( 
		\DOMElement $domElement )
	{

		$this->domElement = $domElement;
		foreach( $domElement->attributes as $attribute )
		{
			$setter = "set" . ucfirst( $attribute->name );
			
			if( method_exists( $this, $setter ) )
			{
				$this->$setter( $attribute->value );
			}
		}
		
		foreach( $domElement->childNodes as $childNode )
		{
			if( $childNode instanceof \DOMElement )
			{
				$element = self::create( $childNode );
				$elementName = $element->getElementTagname();
				$this->__set( $elementName, $element );
			}
		}
	
	}

	public function getElementTagname()
	{

		return $this->elementTagName;
	
	}

}