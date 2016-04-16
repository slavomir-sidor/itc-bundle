<?php

/**
 * SK ITC Bundle DTD Entity
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\ORM\DTD;

use SK\ITCBundle\ORM\DTD\Entity\Character;
use SK\ITCBundle\ORM\DTD\Entity\ExternalPublic;
use SK\ITCBundle\ORM\DTD\Entity\ExternalSystem;
use SK\ITCBundle\ORM\DTD\Entity\Internal;
use SK\ITCBundle\ORM\DTD\Entity\Parameter;

abstract class Entity
{

	/**
	 * SK ITC Bundle DTD Entity Annotation
	 *
	 * @var Annotation
	 */
	protected $annotation;

	/**
	 * SK ITC Bundle DTD Entity Document
	 *
	 * @var Document
	 */
	protected $document;

	/**
	 * SK ITC Bundle DTD Entity Source
	 *
	 * @var Source
	 */
	protected $source;

	/**
	 * SK ITC Bundle DTD Entity Name
	 *
	 * @var string
	 */
	protected $name;

	/**
	 * SK ITC Bundle DTD Entity Value
	 *
	 * @var mixed
	 */
	protected $value;

	/**
	 * Constructs SK ITC Bundle DTD Entity
	 *
	 * @param Document $document
	 *        	SK ITC Bundle DTD Entity Document
	 * @param string $name
	 *        	SK ITC Bundle DTD Entity Name
	 * @param string $source
	 *        	SK ITC Bundle DTD Entity Source
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
	 * Creates SK ITC Bundle DTD Entity
	 *
	 * @param Document $document
	 *        	SK ITC Bundle DTD Entity Document
	 * @param string $name
	 *        	SK ITC Bundle DTD Entity Name
	 * @param string $source
	 *        	SK ITC Bundle DTD Entity Source
	 */
	public static function create( 
		Document $document, 
		$name, 
		$source = NULL )
	{

		$entity = null;
		$sourceAttributes = explode( " ", $source );
		$matches = array();
		
		// External Entity
		if( preg_match( "/(SYSTEM|PUBLIC)/", $source, $matches ) > 0 )
		{
			if( $matches[ 0 ] == 'PUBLIC' )
			{
				$entity = new ExternalPublic( $document, $name, $source );
				if( array_key_exists( 4, $sourceAttributes ) )
				{
					$identifier = $sourceAttributes[ 3 ];
					$uri = $sourceAttributes[ 4 ];
				}
				else
				{
					$identifier = '';
					$uri = $sourceAttributes[ 3 ];
				}
				$entity->setIdentifier( $identifier );
				$entity->setUri( $uri );
			}
			else
			{
				$entity = new ExternalSystem( $document, $name, $source );
			}
		} // Parameter Entity
		else 
			if( preg_match( "/%/", $source, $matches ) > 0 )
			{
				
				$entity = new Parameter( $document, $name, $source );
				$entity->setName( $sourceAttributes[ 1 ] );
				
				if( preg_match( "/\'(.*)\'/", $source, $matches ) > 0 )
				{
					$entity->setValue( $matches[ 1 ] );
				}
				if( preg_match( "/\"(.*)\"/", $source, $matches ) > 0 )
				{
					$entity->setValue( $matches[ 1 ] );
				}
			}
			else
			{
				$entity = new Internal( $document, $name, $source );
			}
		return $entity;
	
	}

	/**
	 * Gets SK ITC Bundle DTD Entity Name
	 *
	 * @return string
	 */
	public function getName()
	{

		return $this->name;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Entity Name
	 *
	 * @param string $name
	 *        	SK ITC Bundle DTD Document Entity Name
	 * @return \SK\ITCBundle\ORM\DTD\Entity
	 */
	public function setName( 
		$name )
	{

		$this->name = ( string ) $name;
		return $this;
	
	}

	/**
	 * Gets SK ITC Bundle DTD Entity Value
	 *
	 * @return mixed
	 */
	public function getValue()
	{

		return $this->value;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Entity Value
	 *
	 * @param mixed $value
	 *        	SK ITC Bundle DTD Entity Value
	 * @return \SK\ITCBundle\ORM\DTD\Entity
	 */
	public function setValue( 
		$value )
	{

		$this->value = $value;
		return $this;
	
	}

	/**
	 * Gets SK ITC Bundle DTD Entity Annotation
	 *
	 * @return \SK\ITCBundle\ORM\DTD\Annotation
	 */
	public function getAnnotation()
	{

		return $this->annotation;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Entity Annotation
	 *
	 * @param Annotation $annotation        	
	 * @return \SK\ITCBundle\ORM\DTD\Entity
	 */
	public function setAnnotation( 
		Annotation $annotation )
	{

		$this->annotation = $annotation;
		return $this;
	
	}

	/**
	 * Gets SK ITC Bundle DTD Entity Source
	 *
	 * @return string
	 */
	public function getSource()
	{

		return $this->source;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Entity Source
	 *
	 * @param string $source
	 *        	SK ITC Bundle DTD Entity Source
	 * @return \SK\ITCBundle\ORM\DTD\Entity
	 */
	public function setSource( 
		$source )
	{

		$this->source = str_replace( PHP_EOL, " ", $source );
		return $this;
	
	}

	/**
	 * Gets SK ITC Bundle DTD Entity Document
	 *
	 * @return Document
	 */
	public function getDocument()
	{

		return $this->document;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Entity Document
	 *
	 * @param Document $document
	 *        	SK ITC Bundle DTD Entity Document
	 * @return \SK\ITCBundle\ORM\DTD\Entity
	 */
	public function setDocument( 
		Document $document )
	{

		$this->document = $document;
		return $this;
	
	}

}