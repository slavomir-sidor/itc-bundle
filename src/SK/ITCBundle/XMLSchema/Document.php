<?php

/**
 * SK ITCBundle XML Schema Document
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\XMLSchema;

use SK\ITCBundle\XML\Document as XMLDocument;
use SK\ITCBundle\XMLSchema\Entity\SchemaEntity;
use SK\ITCBundle\XMLSchema\Entity;

class Document extends XMLDocument
{

	/**
	 * SK ITCBundle XML Schema
	 *
	 * @var SchemaEntity
	 */
	protected $schema;

	/**
	 * SK ITCBundle XML Schema Document Constructor
	 *
	 * @param string $uri
	 *        	SK ITCBundle XML Schema Document Uri
	 */
	public function __construct( 
		$uri )
	{

		parent::__construct( $uri );
		
		foreach( $this->childNodes as $childNode )
		{
			if( $childNode instanceof \DOMElement )
			{
				$this->schema = Entity::create( $childNode );
			}
		}
	
	}

	/**
	 * Gets SK ITCBundle XML Schema Document Schema
	 *
	 * @return Schema
	 */
	public function getSchema()
	{

		return $this->schema;
	
	}

	/**
	 * Sets SK ITCBundle XML Schema Document Schema
	 *
	 * @param SchemaElement $schema        	
	 */
	public function setSchema( 
		SchemaEntity $schema )
	{

		$this->schema = $schema;
		return $this;
	
	}

}