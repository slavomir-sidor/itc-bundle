<?php

/**
 * SK ITC Bundle DTD Attribute List
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\ORM\DTD\Attribute;

class AttributeList
{

	/**
	 * SK ITC Bundle DTD Attribute List Annotation
	 *
	 * @var Annotation
	 */
	protected $annotation;

	/**
	 * SK ITC Bundle DTD Attribute List Attribute
	 *
	 * @var Attribute[]
	 */
	protected $attribute;

	/**
	 * SK ITC Bundle DTD Attribute List Document
	 *
	 * @var Document
	 */
	protected $document;

	/**
	 * SK ITC Bundle DTD Attribute List Element
	 *
	 * @var Element
	 */
	protected $element;

	/**
	 * SK ITC Bundle DTD Attribute List Name
	 *
	 * @var string
	 */
	protected $name;

	/**
	 * SK ITC Bundle DTD Attribute List Source
	 *
	 * @var string
	 */
	protected $source;

	/**
	 * Constructs SK ITC Bundle DTD Attribute List
	 *
	 * @param Document $document
	 *        	SK ITC Bundle DTD Attribute List Document
	 * @param string $name
	 *        	SK ITC Bundle DTD Attribute List Name
	 * @param string $source
	 *        	SK ITC Bundle DTD Attribute List Source
	 */
	public function __construct( 
		Document $document, 
		$name, 
		$source = NULL )
	{

		$this->setDocument( $document );
		$this->setName( $name );
		$this->setSource( $source );
	
	}

	/**
	 * Loads SK ITC Bundle DTD Attribute List
	 */
	public function load()
	{

		if( TRUE !== $this->getLoaded() )
		{
			$this->setLoaded( TRUE );
		}
	
	}

	/**
	 * Creates SK ITC Bundle DTD Attribute List
	 *
	 * @param string $source
	 *        	SK ITC Bundle DTD Attribute List Source
	 * @return \SK\ITCBundle\ORM\DTD\AttributeList
	 */
	public static function create( 
		$source, 
		Document $document )
	{

		$entity = null;
		
		$sourceAttributes = explode( " ", $source );
		$instance = new self( $source );
		$entity = array_shift( $sourceAttributes );
		
		$j = 0;
		for( $i = 0; $i < count( $sourceAttributes ); $i ++ )
		{
			$sourceAttribute = $sourceAttributes[ $i ];
			
			if( preg_match( "/%/", $sourceAttribute ) && $j == 0 )
			{
				$j = $j + 2;
				$attribute = new Attribute( "" );
				$instance->setAttribute( $attribute );
			}
			else
			{
				$column = $j % 3;
				switch( $column )
				{
					case 0:
						$attributeName = $sourceAttribute;
						++ $j;
						break;
					case 1:
						$attributeEntity = $sourceAttribute;
						++ $j;
						break;
					case 2:
						$attributeDefaultValue = $sourceAttribute;
						$attribute = new Attribute( "" );
						$attribute->setDocument( $document );
						$attribute->setName( $attributeName );
						$attribute->setEntity( $document->getEntity( $attributeEntity ) );
						$attribute->setDefaultValue( $attributeDefaultValue );
						$instance->setAttribute( $attribute );
						$j = 0;
						break;
				}
			}
		}
		
		return $instance;
	
	}

	/**
	 * Gets SK ITC Bundle DTD Attribute List Annotation
	 *
	 * @return \SK\ITCBundle\ORM\DTD\Annotation
	 */
	public function getAnnotation()
	{

		return $this->annotation;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Attribute List Annotation
	 *
	 * @param Annotation $annotation
	 *        	SK ITC Bundle DTD Attribute List Annotation
	 * @return \SK\ITCBundle\ORM\DTD\AttributeList
	 */
	public function setAnnotation( 
		Annotation $annotation )
	{

		$this->annotation = $annotation;
		return $this;
	
	}

	/**
	 * Gets SK ITC Bundle DTD Attribute List Name
	 *
	 * @return string
	 */
	public function getName()
	{

		return $this->name;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Attribute List Name
	 *
	 * @param string $name
	 *        	SK ITC Bundle DTD Document Attribute List Name
	 * @return \SK\ITCBundle\ORM\DTD\AttributeList
	 */
	public function setName( 
		$name )
	{

		$this->name = ( string ) $name;
		return $this;
	
	}

	/**
	 * Gets SK ITC Bundle DTD Attribute List Source
	 *
	 * @return the string
	 */
	public function getSource()
	{

		return $this->source;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Attribute List Source
	 *
	 * @param string $source
	 *        	SK ITC Bundle DTD Attribute List Source
	 * @return \SK\ITCBundle\ORM\DTD\AttributeList
	 */
	public function setSource( 
		$source )
	{

		$this->source = $source;
		return $this;
	
	}

	/**
	 * Gets SK ITC Bundle DTD Attribute List Document
	 *
	 * @return Document
	 */
	public function getDocument()
	{

		return $this->document;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Attribute List Document
	 *
	 * @param Document $document
	 *        	SK ITC Bundle DTD Attribute List Document
	 * @return \SK\ITCBundle\ORM\DTD\AttributeList
	 */
	public function setDocument( 
		Document $document )
	{

		$this->document = $document;
		return $this;
	
	}

	/**
	 * Gets SK ITC Bundle DTD Attribute List Element
	 *
	 * @return Element
	 */
	public function getElement()
	{

		return $this->element;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Attribute List Element
	 *
	 * @param Element $element
	 *        	SK ITC Bundle DTD Attribute List Element
	 * @return \SK\ITCBundle\ORM\DTD\AttributeList
	 */
	public function setElement( 
		Element $element )
	{

		$this->element = $element;
		return $this;
	
	}

	/**
	 * Gets SK ITC Bundle DTD Attribute List Attribute
	 *
	 * @return Attribute[]
	 */
	public function getAttribute()
	{

		return $this->attribute;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Attribute List Attribute
	 *
	 * @param Attribute $attribute
	 *        	SK ITC Bundle DTD Attribute List Attribute
	 * @return \SK\ITCBundle\ORM\DTD\AttributeList
	 */
	public function setAttribute( 
		Attribute $attribute )
	{

		$this->attribute[ $attribute->getName() ] = $attribute;
		return $this;
	
	}

	/**
	 * Gets SK ITC Bundle DTD Attribute List Loaded Flag
	 *
	 * @return boolean
	 */
	public function getLoaded()
	{

		return $this->loaded;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Attribute List Loaded Flag
	 *
	 * @param boolean $loaded
	 *        	SK ITC Bundle DTD Attribute List Loaded Flag
	 * @return \SK\ITCBundle\ORM\DTD\AttributeList
	 */
	public function setLoaded( 
		$loaded )
	{

		$this->loaded = $loaded;
		return $this;
	
	}

}