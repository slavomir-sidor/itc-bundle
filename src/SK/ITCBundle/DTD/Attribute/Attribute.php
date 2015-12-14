<?php

/**
 * SK ITC Bundle DTD Attribute
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\DTD\Attribute;

use SK\ITCBundle\DTD\Entity;
use SK\ITCBundle\DTD\Document;
use SK\ITCBundle\DTD\Element;

class Attribute extends Entity
{
	
	/**
	 * SK ITC Bundle DTD Attribute Annotation
	 *
	 * @var Annotation
	 */
	protected $annotation;
	
	/**
	 * SK ITC Bundle DTD Attribute Document
	 *
	 * @var Document
	 */
	protected $document;
	
	/**
	 * SK ITC Bundle DTD Attribute Name
	 *
	 * @var string
	 */
	protected $name;
	
	/**
	 * SK ITC Bundle DTD Attribute Source
	 *
	 * @var string
	 */
	protected $source;
	
	/**
	 * SK ITC Bundle DTD Attribute Entity
	 *
	 * @var Entity
	 */
	protected $entity;
	
	/**
	 * SK ITC Bundle DTD Attribute Element
	 *
	 * @var Element
	 */
	protected $element;
	
	/**
	 * SK ITC Bundle DTD Attribute Value
	 *
	 * @var mixed
	 */
	protected $value;
	
	/**
	 * SK ITC Bundle DTD Attribute Default Value
	 *
	 * @var mixed
	 */
	protected $defaultValue;
	
	/**
	 * Constructs SK ITC Bundle DTD Attribute
	 *
	 * @param Document $document
	 *        	SK ITC Bundle DTD Attribute Document
	 * @param string $name
	 *        	SK ITC Bundle DTD Attribute Name
	 * @param string $source
	 *        	SK ITC Bundle DTD Attribute Source
	 */
	public function __construct( Document $document, $name, $source = NULL )
	{
		$this->setDocument( $document );
		$this->setSource( $name );
		$this->setSource( $source );
	}
	
	/**
	 * Creates SK ITC Bundle DTD Attribute
	 *
	 * @param string $source
	 *        	SK ITC Bundle DTD Attribute Source
	 * @return \SK\ITCBundle\DTD\Attribute
	 */
	public static function create( Document $document, $source )
	{
		$instance = new self( $source );
		return $instance;
	}
	
	/**
	 * Gets SK ITC Bundle DTD Attribute Annotation
	 *
	 * @return \SK\ITCBundle\DTD\Annotation
	 */
	public function getAnnotation()
	{
		return $this->annotation;
	}
	
	/**
	 * Sets SK ITC Bundle DTD Attribute Annotation
	 *
	 * @param Annotation $annotation
	 *        	SK ITC Bundle DTD Attribute Annotation
	 * @return \SK\ITCBundle\DTD\Attribute
	 */
	public function setAnnotation( Annotation $annotation )
	{
		$this->annotation = $annotation;
		return $this;
	}
	
	/**
	 * Gets SK ITC Bundle DTD Attribute Name
	 *
	 * @return string
	 */
	public function getName()
	{
		return $this->name;
	}
	
	/**
	 * Sets SK ITC Bundle DTD Attribute Name
	 *
	 * @param string $name
	 *        	SK ITC Bundle DTD Attribute Name
	 * @return \SK\ITCBundle\DTD\Attribute
	 */
	public function setName( $name )
	{
		$this->name = ( string ) $name;
		return $this;
	}
	
	/**
	 * Gets SK ITC Bundle DTD Attribute Entity
	 *
	 * @return string
	 */
	public function getEntity()
	{
		return $this->entity;
	}
	
	/**
	 * Sets SK ITC Bundle DTD Attribute Entity
	 *
	 * @param string $entity
	 *        	SK ITC Bundle DTD Attribute Entity
	 * @return \SK\ITCBundle\DTD\Attribute
	 */
	public function setEntity( $entity )
	{
		$this->entity = $entity;
		return $this;
	}
	
	/**
	 * Gets SK ITC Bundle DTD Attribute Value
	 *
	 * @return mixed
	 */
	public function getValue()
	{
		return $this->value;
	}
	
	/**
	 * Sets SK ITC Bundle DTD Attribute Value
	 *
	 * @param mixed $value        	
	 * @return \SK\ITCBundle\DTD\Attribute
	 */
	public function setValue( $value )
	{
		$this->value = $value;
		return $this;
	}
	
	/**
	 * Gets SK ITC Bundle DTD Attribute Default Value
	 *
	 * @return mixed
	 */
	public function getDefaultValue()
	{
		return $this->defaultValue;
	}
	
	/**
	 * Sets SK ITC Bundle DTD Attribute Default Value
	 *
	 * @param mixed $defaultValue        	
	 * @return \SK\ITCBundle\DTD\Attribute
	 */
	public function setDefaultValue( $defaultValue )
	{
		$this->defaultValue = $defaultValue;
		return $this;
	}
	
	/**
	 * Gets SK ITC Bundle DTD Attribute Source
	 *
	 * @return the string
	 */
	public function getSource()
	{
		return $this->source;
	}
	
	/**
	 * Sets SK ITC Bundle DTD Attribute Source
	 *
	 * @param string $source
	 *        	SK ITC Bundle DTD Attribute Source
	 * @return \SK\ITCBundle\DTD\Attribute
	 */
	public function setSource( $source )
	{
		$this->source = $source;
		return $this;
	}
	
	/**
	 * Gets SK ITC Bundle DTD Attribute Document
	 *
	 * @return Document
	 */
	public function getDocument()
	{
		return $this->document;
	}
	
	/**
	 * Sets SK ITC Bundle DTD Attribute Document
	 *
	 * @param Document $document
	 *        	SK ITC Bundle DTD Attribute Document
	 * @return \SK\ITCBundle\DTD\Attribute
	 */
	public function setDocument( Document $document )
	{
		$this->document = $document;
		return $this;
	}
	
	/**
	 * Gets SK ITC Bundle DTD Attribute Element
	 *
	 * @return Element
	 */
	public function getElement()
	{
		return $this->element;
	}
	
	/**
	 * Sets SK ITC Bundle DTD Attribute Element
	 *
	 * @param Element $element
	 *        	SK ITC Bundle DTD Attribute Element
	 * @return \SK\ITCBundle\DTD\Attribute
	 */
	public function setElement( Element $element )
	{
		$this->element = $element;
		return $this;
	}
}