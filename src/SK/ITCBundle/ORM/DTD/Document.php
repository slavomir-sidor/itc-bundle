<?php

/**
 * SK ITC Bundle DTD Document
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\ORM\DTD;

use SK\ITCBundle\ORM\Document\Document as ITCDocument;
use SK\ITCBundle\ORM\DTD\Attribute\AttributeList;

class Document extends ITCDocument
{

	/**
	 * SK ITC Bundle DTD Document Attribute List
	 *
	 * @var AttributeList[]
	 */
	protected $attributeList;

	/**
	 * SK ITC Bundle DTD Document Element
	 *
	 * @var Element[]
	 */
	protected $element;

	/**
	 * SK ITC Bundle DTD Document Entity
	 *
	 * @var Entity[]
	 */
	protected $entity;

	/**
	 * SK ITC Bundle DTD Document Source
	 *
	 * @var Source
	 */
	protected $source;

	/**
	 * SK ITC Bundle DTD Document Source Definitions
	 *
	 * @var array
	 */
	protected $sourceDefinitions;

	/**
	 * SK ITC Bundle DTD Document Annotation
	 *
	 * @var Annotation[]
	 */
	protected $annotation;

	/**
	 * SK ITC Bundle DTD Document Loaded Flag
	 *
	 *
	 * @var boolean
	 */
	protected $loaded;

	/**
	 * Constructs SK ITC Bundle DTD Document
	 *
	 * @param string $uri
	 *        	SK ITC Bundle DTD Document URI
	 */
	public function __construct( 
		$uri )
	{

		parent::__construct( $uri );
	
	}

	/**
	 * Gets SK ITC Bundle DTD Document Source
	 *
	 * @return \SK\ITCBundle\ORM\DTD\Source
	 */
	public function getSource()
	{

		if( NULL === $this->source )
		{
			$source = new Source( $this );
			$this->setSource( $source );
		}
		
		return $this->source;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Document Source
	 *
	 * @param Source $source
	 *        	SK ITC Bundle DTD Document Source
	 */
	public function setSource( 
		Source $source )
	{

		$this->source = $source;
		return $this;
	
	}

	/**
	 * Gets SK ITC Bundle DTD Document Element
	 *
	 * @param string $name
	 *        	SK ITC Bundle DTD Document Element Name
	 * @return \SK\ITCBundle\ORM\DTD\Element[]
	 */
	public function getElement( 
		$name = null )
	{

		if( NULL === $this->element )
		{
			$this->element = new \ArrayIterator();
		}
		if( NULL !== $name )
		{
			if( ! $this->getElement()
				->offsetExists( $name ) )
			{
				$source = $this->getSource()
					->getElement( $name );
				$element = new Element( $this, $name, $source );
				$this->setElement( $element );
			}
			return $this->element->offsetGet( $name );
		}
		else
		{
			foreach( $this->getSource()
				->getElement() as $name => $source )
			{
				$element = new Element( $this, $name, $source );
				$this->setElement( $element );
			}
		}
		
		return $this->element;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Document Element
	 *
	 * @param Element $element
	 *        	SK ITC Bundle DTD Document Element
	 * @return \SK\ITCBundle\ORM\DTD\Document
	 */
	public function setElement( 
		Element $element )
	{

		$this->element[ $element->getName() ] = $element;
		$element->setDocument( $this );
		
		return $this;
	
	}

	/**
	 * Gets SK ITC Bundle DTD Document Attribute List
	 *
	 * @return AttributeList[]
	 */
	public function getAttributeList( 
		$name = NULL )
	{

		if( NULL === $this->attributeList )
		{
			$this->attributeList = new \ArrayIterator();
		}
		if( NULL !== $name )
		{
			if( ! $this->attributeList->offsetExists( $name ) )
			{
				$source = $this->getSource()
					->getAttributeList( $name );
				$attributeList = new AttributeList( $this, $name, $source );
				$this->setAttributeList( $attributeList );
			}
			return $this->attributeList->offsetGet( $name );
		}
		else
		{
			foreach( $this->getSource()
				->getAttributeList() as $name => $source )
			{
				$attributeList = new AttributeList( $this, $name, $source );
				$this->setAttributeList( $attributeList );
			}
		}
		return $this->attributeList;
	
	}

	/**
	 * Sets Gets SK ITC Bundle DTD Document Attribute List
	 *
	 * @param AttributeList $attributeList
	 *        	SK ITC Bundle DTD Document Attribute List
	 * @return \SK\ITCBundle\ORM\DTD\Document
	 */
	public function setAttributeList( 
		AttributeList $attributeList )
	{

		$this->attributeList[ $attributeList->getName() ] = $attributeList;
		$attributeList->setDocument( $this );
		return $this;
	
	}

	/**
	 * Gets SK ITC Bundle DTD Document Entity
	 *
	 * @return Entity[]
	 */
	public function getEntity( 
		$name = NULL )
	{

		if( NULL === $this->entity )
		{
			$this->entity = new \ArrayIterator();
		}
		
		if( NULL !== $name )
		{
			if( ! $this->entity->offsetExists( $name ) )
			{
				$source = $this->getSource()
					->getEntity( $name );
				$entity = Entity::create( $this, $name, $source );
				$this->setEntity( $entity );
			}
			return $this->entity->offsetGet( $name );
		}
		else
		{
			foreach( $this->getSource()
				->getEntity() as $name => $source )
			{
				$entity = Entity::create( $this, $name, $source );
				$this->setEntity( $entity );
			}
		}
		
		return $this->entity;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Document Entity
	 *
	 * @param Entity $entity
	 *        	SK ITC Bundle DTD Document Entity
	 * @return \SK\ITCBundle\ORM\DTD\Document
	 */
	public function setEntity( 
		Entity $entity )
	{

		$this->entity[ $entity->getName() ] = $entity;
		$entity->setDocument( $this );
		return $this;
	
	}

	/**
	 * Gets SK ITC Bundle DTD Document Annotation
	 *
	 * @return the Annotation[]
	 */
	public function getAnnotation()
	{

		return $this->annotation;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Document Annotation
	 *
	 * @param Annotation $annotation
	 *        	SK ITC Bundle DTD Document Annotation
	 * @return \SK\ITCBundle\ORM\DTD\Document
	 */
	public function setAnnotation( 
		Annotation $annotation )
	{

		$this->annotation[] = $annotation;
		return $this;
	
	}

}