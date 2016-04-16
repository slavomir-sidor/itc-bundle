<?php

/**
 * SK ITCBundle XML Element
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\ORM\XMLSchema;

class Element
{

	/**
	 * SK ITCBundle XML Schema Element Id
	 *
	 * @var string
	 */
	protected $id;

	/**
	 * SK ITCBundle XML Schema Element Name
	 *
	 * @var string
	 */
	protected $name;

	/**
	 * SK ITCBundle XML Schema Lang
	 *
	 * @var string
	 */
	protected $lang;

	/**
	 * SK ITCBundle XML Element Form Default
	 *
	 * @var string
	 */
	protected $elementFormDefault;

	/**
	 * SK ITCBundle XML Element Target Namespace
	 *
	 * @var string
	 */
	protected $targetNamespace;

	/**
	 * SK ITCBundle XML Element Namespace
	 *
	 * @var string
	 */
	protected $namespace;

	/**
	 * SK ITCBundle XML Element Version
	 *
	 * @var string
	 */
	protected $version;

	/**
	 * SK ITCBundle XML Element Source
	 *
	 * @var string
	 */
	protected $source;

	/**
	 * SK ITCBundle XML Element Schema Location
	 *
	 * @var string
	 */
	protected $schemaLocation;

	/**
	 * SK ITCBundle XML Element Abstract
	 *
	 * @var string
	 */
	protected $abstract;

	/**
	 * SK ITCBundle XML Element Type
	 *
	 * @var string
	 */
	protected $type;

	/**
	 * SK ITCBundle XML Element Public
	 *
	 * @var string
	 */
	protected $public;

	/**
	 * SK ITCBundle XML Element System
	 *
	 * @var string
	 */
	protected $system;

	/**
	 * SK ITCBundle XML Element Mixed
	 *
	 * @var string
	 */
	protected $mixed;

	/**
	 * SK ITCBundle XML Element Substitution Group
	 *
	 * @var string
	 */
	protected $substitutionGroup;

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
		foreach( $domElement->attributes as $attribute )
		{
			$setter = "set" . ucfirst( $attribute->name );
			$this->$setter( $attribute->value );
		}
		
		print $domElement->tagName . "\n";
		
		foreach( $domElement->childNodes as $childNode )
		{
			if( $childNode instanceof \DOMElement )
			{
				$element = Document::createEntity( $childNode );
			}
		}
	
	}

	/**
	 * Gets SK ITCBundle XML Document XPath
	 *
	 * @return DOMXPath
	 */
	protected function getXpath()
	{

		if( null === $this->xpath )
		{
			$this->setXpath( new \DOMXPath( $this ) );
		}
		return $this->xpath;
	
	}

	protected function setXpath( 
		\DOMXPath $xpath )
	{

		$this->xpath = $xpath;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle XML Element PHP DOM Element
	 *
	 * @return \DOMElement
	 */
	public function getDOMElement()
	{

		return $this->domElement;
	
	}

	/**
	 * Sets SK ITCBundle XML Element PHP DOM Element
	 *
	 * @param \DOMElement $element        	
	 * @return \SK\ITCBundle\ORM\XML\Element
	 */
	public function setDOMElement( 
		\DOMElement $domElement )
	{

		$this->domElement = $domElement;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle XML Element Id
	 *
	 * @return string
	 */
	public function getId()
	{

		return $this->id;
	
	}

	/**
	 * Sets SK ITCBundle XML Element Id
	 *
	 * @param string $id
	 *        	SK ITCBundle XML Element Id
	 * @return \SK\ITCBundle\ORM\XMLSchema\Element
	 */
	public function setId( 
		$id )
	{

		$this->id = ( string ) $id;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle XML Element Form Default
	 *
	 * @return string
	 */
	public function getElementFormDefault()
	{

		return $this->elementFormDefault;
	
	}

	/**
	 * Sets SK ITCBundle XML Element Form Default
	 *
	 * @param string $elementFormDefault
	 *        	SK ITCBundle XML Element Form Default
	 */
	public function setElementFormDefault( 
		$elementFormDefault )
	{

		$this->elementFormDefault = ( string ) $elementFormDefault;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle XML Schema Lang
	 *
	 * @return string
	 */
	public function getLang()
	{

		return $this->lang;
	
	}

	/**
	 * Sets SK ITCBundle XML Schema Lang
	 *
	 * @param string $lang
	 *        	SK ITCBundle XML Schema Lang
	 * @return \SK\ITCBundle\ORM\XML\Element
	 */
	public function setLang( 
		$lang )
	{

		$this->lang = $lang;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle XML Element Target Namespace
	 *
	 * @return string
	 */
	public function getTargetNamespace()
	{

		return $this->targetNamespace;
	
	}

	/**
	 * Sets SK ITCBundle XML Element Target Namespace
	 *
	 * @param string $targetNamespace
	 *        	SK ITCBundle XML Element Target Namespace
	 * @return \SK\ITCBundle\ORM\XML\Element
	 */
	public function setTargetNamespace( 
		$targetNamespace )
	{

		$this->targetNamespace = $targetNamespace;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle XML Element Version
	 *
	 * @return string
	 */
	public function getVersion()
	{

		return $this->version;
	
	}

	/**
	 * Sets SK ITCBundle XML Element Version
	 *
	 * @param string $version
	 *        	SK ITCBundle XML Element Version
	 */
	public function setVersion( 
		$version )
	{

		$this->version = ( string ) $version;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle XML Element Source
	 *
	 * @return string
	 */
	public function getSource()
	{

		return $this->source;
	
	}

	/**
	 * Sets SK ITCBundle XML Element Source
	 *
	 * @param string $source
	 *        	SK ITCBundle XML Element Source
	 * @return \SK\ITCBundle\ORM\XML\Element
	 */
	public function setSource( 
		$source )
	{

		$this->source = ( string ) $source;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle XML Element Namespace
	 *
	 * @return string
	 */
	public function getNamespace()
	{

		return $this->namespace;
	
	}

	/**
	 * Sets SK ITCBundle XML Element Namespace
	 *
	 * @param string $namespace
	 *        	SK ITCBundle XML Element Namespace
	 */
	public function setNamespace( 
		$namespace )
	{

		$this->namespace = ( string ) $namespace;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle XML Element Schema Location
	 *
	 * @return string
	 */
	public function getSchemaLocation()
	{

		return $this->schemaLocation;
	
	}

	/**
	 * Sets SK ITCBundle XML Element Schema Location
	 *
	 * @param string $schemaLocation        	
	 * @return \SK\ITCBundle\ORM\XML\Element
	 */
	public function setSchemaLocation( 
		$schemaLocation )
	{

		$this->schemaLocation = ( string ) $schemaLocation;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle XML Schema Element Name
	 *
	 * @return string
	 */
	public function getName()
	{

		return $this->name;
	
	}

	/**
	 * Sets SK ITCBundle XML Schema Element Name
	 *
	 * @param string $name
	 *        	SK ITCBundle XML Schema Element Name
	 * @return \SK\ITCBundle\ORM\XML\Element
	 */
	public function setName( 
		$name )
	{

		$this->name = ( string ) $name;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle XML Element Abstract
	 *
	 * @return string
	 */
	public function getAbstract()
	{

		return $this->abstract;
	
	}

	/**
	 * Sets SK ITCBundle XML Element Abstract
	 *
	 * @param string $abstract
	 *        	SK ITCBundle XML Element Abstract
	 * @return \SK\ITCBundle\ORM\XML\Element
	 */
	public function setAbstract( 
		$abstract )
	{

		$this->abstract = ( string ) $abstract;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle XML Element Type
	 *
	 * @return string
	 */
	public function getType()
	{

		return $this->type;
	
	}

	/**
	 * Sets SK ITCBundle XML Element Type
	 *
	 * @param string $type
	 *        	SK ITCBundle XML Element Type
	 * @return \SK\ITCBundle\ORM\XML\Element
	 */
	public function setType( 
		$type )
	{

		$this->type = ( string ) $type;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle XML Element Public
	 *
	 * @return string
	 */
	public function getPublic()
	{

		return $this->public;
	
	}

	/**
	 * Sets SK ITCBundle XML Element Public
	 *
	 * @param string $public
	 *        	SK ITCBundle XML Element Public
	 * @return \SK\ITCBundle\ORM\XML\Element
	 */
	public function setPublic( 
		$public )
	{

		$this->public = ( string ) $public;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle XML Element System
	 *
	 * @return string
	 */
	public function getSystem()
	{

		return $this->system;
	
	}

	/**
	 * Sets SK ITCBundle XML Element System
	 *
	 * @param string $system
	 *        	SK ITCBundle XML Element System
	 * @return \SK\ITCBundle\ORM\XML\Element
	 */
	public function setSystem( 
		$system )
	{

		$this->system = ( string ) $system;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle XML Element Mixed
	 *
	 * @return string
	 */
	public function getMixed()
	{

		return $this->mixed;
	
	}

	/**
	 * Sets SK ITCBundle XML Element Mixed
	 *
	 * @param string $mixed
	 *        	SK ITCBundle XML Element Mixed
	 * @return \SK\ITCBundle\ORM\XML\Element
	 */
	public function setMixed( 
		$mixed )
	{

		$this->mixed = ( string ) $mixed;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle XML Element Substitution Group
	 *
	 * @return string
	 */
	public function getSubstitutionGroup()
	{

		return $this->substitutionGroup;
	
	}

	/**
	 * Sets SK ITCBundle XML Element Substitution Group
	 *
	 * @param string $substitutionGroup
	 *        	SK ITCBundle XML Element Substitution Group
	 * @return \SK\ITCBundle\ORM\XML\Element
	 */
	public function setSubstitutionGroup( 
		$substitutionGroup )
	{

		$this->substitutionGroup = ( string ) $substitutionGroup;
		return $this;
	
	}

}