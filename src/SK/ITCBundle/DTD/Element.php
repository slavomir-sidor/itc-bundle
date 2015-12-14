<?php

/**
 * SK ITC Bundle DTD Element
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\DTD;

class Element
{
	
	/**
	 * SK ITC Bundle DTD Element Annotation
	 *
	 * @var Annotation
	 */
	protected $annotation;
	
	/**
	 * SK ITC Bundle DTD Element Attribute List
	 *
	 * @var AttributeList
	 */
	protected $attributeList;
	
	/**
	 * SK ITC Bundle DTD Element Document
	 *
	 * @var Document
	 */
	protected $document;
	
	/**
	 * SK ITC Bundle DTD Element Entity
	 *
	 * @var string
	 */
	protected $entity;
	
	/**
	 * SK ITC Bundle DTD Element Name
	 *
	 * @var string
	 */
	protected $name;
	
	/**
	 * SK ITC Bundle DTD Element Value
	 *
	 * @var string
	 */
	protected $value;
	
	/**
	 * SK ITC Bundle DTD Element Source
	 *
	 * @var string
	 */
	protected $source;
	
	/**
	 * SK ITC Bundle DTD Element Name
	 *
	 * @var Element[]
	 */
	protected $children;
	
	/**
	 * Constructs SK ITC Bundle DTD Element
	 *
	 * @param Document $document
	 *        	SK ITC Bundle DTD Element Document
	 * @param string $name
	 *        	SK ITC Bundle DTD Element Name
	 * @param string $source
	 *        	SK ITC Bundle DTD Element Source
	 */
	public function __construct( Document $document, $name, $source = NULL )
	{
		$this->setDocument( $document );
		$this->setName( $name );
		$this->setSource( $source );
	}
	
	/**
	 * Gets SK ITC Bundle DTD Element Annotation
	 *
	 * @return \SK\ITCBundle\DTD\Annotation
	 */
	public function getAnnotation()
	{
		return $this->annotation;
	}
	
	/**
	 * Sets SK ITC Bundle DTD Element Annotation
	 *
	 * @param Annotation $annotation
	 *        	SK ITC Bundle DTD Element Annotation
	 * @return \SK\ITCBundle\DTD\Element
	 */
	public function setAnnotation( Annotation $annotation )
	{
		$this->annotation = $annotation;
		return $this;
	}
	
	/**
	 * Gets SK ITC Bundle DTD Element Name
	 *
	 * @return string
	 */
	public function getName()
	{
		return $this->name;
	}
	
	/**
	 * Sets SK ITC Bundle DTD Element Name
	 *
	 * @param string $name
	 *        	SK ITC Bundle DTD Element Name
	 * @return \SK\ITCBundle\DTD\Element
	 */
	public function setName( $name )
	{
		$this->name = ( string ) $name;
		return $this;
	}
	
	/**
	 * Gets SK ITC Bundle DTD Element Entity
	 *
	 * @return string
	 */
	public function getEntity()
	{
		return $this->entity;
	}
	
	/**
	 * Sets SK ITC Bundle DTD Element Entity
	 *
	 * @param string $entity
	 *        	SK ITC Bundle DTD Element Entity
	 * @return \SK\ITCBundle\DTD\Element
	 */
	public function setEntity( $entity )
	{
		$this->entity = $entity;
		return $this;
	}
	
	/**
	 * Gets SK ITC Bundle DTD Element Attribute List
	 *
	 * @return AttributeList
	 */
	public function getAttributeList()
	{
		return $this->attributeList;
	}
	
	/**
	 * Sets SK ITC Bundle DTD Element Attribute List
	 *
	 * @param AttributeList $attributeList
	 *        	SK ITC Bundle DTD Element Attribute List
	 * @return \SK\ITCBundle\DTD\Element
	 */
	public function setAttributes( $attributeList )
	{
		$this->attributeList = $attributeList;
		return $this;
	}
	
	/**
	 * Gets SK ITC Bundle DTD Element Children Element
	 *
	 * @return Element[]
	 */
	public function getChildren()
	{
		return $this->children;
	}
	
	/**
	 * Sets SK ITC Bundle DTD Element Children Element
	 *
	 * @param Element $children
	 *        	SK ITC Bundle DTD Element Children Element
	 * @return \SK\ITCBundle\DTD\Element
	 */
	public function setChildren( $children )
	{
		$this->children = $children;
		return $this;
	}
	
	/**
	 * Gets SK ITC Bundle DTD Element Source
	 *
	 * @return string
	 */
	public function getSource()
	{
		return $this->source;
	}
	
	/**
	 * Sets SK ITC Bundle DTD Element Source
	 *
	 * @param string $source
	 *        	SK ITC Bundle DTD Element Source
	 * @return \SK\ITCBundle\DTD\Element
	 */
	public function setSource( $source )
	{
		$this->source = $source;
		return $this;
	}
	
	/**
	 * Gets SK ITC Bundle DTD Element Document
	 *
	 * @return Document
	 */
	public function getDocument()
	{
		return $this->document;
	}
	
	/**
	 * Sets SK ITC Bundle DTD Element Document
	 *
	 * @param Document $document
	 *        	SK ITC Bundle DTD Element Document
	 * @return \SK\ITCBundle\DTD\Element
	 */
	public function setDocument( Document $document )
	{
		$this->document = $document;
		return $this;
	}
	
	/**
	 * Gets SK ITC Bundle DTD Element Value
	 *
	 * @return string
	 */
	public function getValue()
	{
		return $this->value;
	}
	
	/**
	 * Sets SK ITC Bundle DTD Element Value
	 *
	 * @param mixed $value
	 *        	SK ITC Bundle DTD Element Value
	 * @return \SK\ITCBundle\DTD\Element
	 */
	public function setValue( $value )
	{
		$this->value = $value;
		return $this;
	}
}