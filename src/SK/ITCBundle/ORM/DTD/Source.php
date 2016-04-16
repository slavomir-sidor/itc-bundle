<?php

/**
 * SK ITC Bundle DTD Source
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\ORM\DTD;

use SK\ITCBundle\ORM\Document\Source as ITCSource;

class Source extends ITCSource
{

	/**
	 * SK ITC Bundle DTD Source Annotation
	 *
	 * @var \ArrayIterator
	 */
	protected $annotation;

	/**
	 * SK ITC Bundle DTD Source Entity
	 *
	 * @var \ArrayIterator
	 */
	protected $entity;

	/**
	 * SK ITC Bundle DTD Source Element
	 *
	 * @var \ArrayIterator
	 */
	protected $element;

	/**
	 * SK ITC Bundle DTD Source Attribute List
	 *
	 * @var \ArrayIterator
	 */
	protected $attributeList;

	/**
	 * SK ITC Bundle DTD Source Delimiter
	 *
	 * @var string
	 */
	const DELIMITER = ' ';

	/**
	 * Reads SK ITC Bundle DTD Source
	 */
	protected function read()
	{

		$document = $this->getDocument();
		while( ! $document->eof() )
		{
			$this->readAnnotation();
			$this->readEntity();
			$this->readElement();
			$this->readAttributeList();
			
			if( ! $document->eof() )
			{
				$document->next();
			}
		}
	
	}

	/**
	 * SK ITC Bundle DTD Source
	 */
	protected function readAnnotation()
	{

		$document = $this->getDocument();
		$line = $document->current();
		
		// Annotation
		$matches = array();
		if( preg_match_all( "/^<!--(.*)/", $line, $matches ) )
		{
			$line = trim( $matches[ 1 ][ 0 ] );
			$annotation = "";
			while( preg_match_all( "/^(.*)-->/", $line, $matches ) < 1 && ! $document->eof() )
			{
				$annotation .= " " . $line;
				$document->next();
				$line = $document->current();
			}
			$annotation .= " " . $matches[ 1 ][ 0 ];
			$this->setAnnotation( $annotation );
		}
	
	}

	protected function readEntity()
	{

		$document = $this->getDocument();
		$line = $document->current();
		$matches = array();
		if( preg_match_all( "/^<!ENTITY(.*)/", $line, $matches ) )
		{
			$line = trim( $matches[ 1 ][ 0 ] );
			$source = "";
			while( preg_match_all( "/^(.*)>/", $line, $matches ) < 1 && ! $document->eof() )
			{
				$source .= " " . $line;
				$document->next();
				$line = $document->current();
			}
			$source .= " " . $matches[ 1 ][ 0 ];
			$source = self::normalizeSource( $source );
			$sourceOptions = explode( self::DELIMITER, $source );
			$index = $sourceOptions[ 1 ];
			$this->setEntity( $index, $source );
		}
	
	}

	protected function readElement()
	{

		$document = $this->getDocument();
		$line = $document->current();
		$matches = array();
		if( preg_match_all( "/^<!ELEMENT(.*)/", $line, $matches ) )
		{
			$line = trim( $matches[ 1 ][ 0 ] );
			$source = "";
			while( preg_match_all( "/^(.*)>/", $line, $matches ) < 1 && ! $document->eof() )
			{
				$source .= " " . $line;
				$document->next();
				$line = $document->current();
			}
			$source .= " " . $matches[ 1 ][ 0 ];
			$source = self::normalizeSource( $source );
			$sourceOptions = explode( self::DELIMITER, $source );
			
			$index = trim( str_replace( ";", "", str_replace( "%", "", $sourceOptions[ 0 ] ) ) );
			$this->setElement( $index, $source );
		}
	
	}

	protected function readAttributeList()
	{

		$document = $this->getDocument();
		$line = $document->current();
		$matches = array();
		if( preg_match_all( "/^<!ATTLIST(.*)/", $line, $matches ) )
		{
			$line = trim( $matches[ 1 ][ 0 ] );
			$source = "";
			while( preg_match_all( "/^(.*)>/", $line, $matches ) < 1 && ! $document->eof() )
			{
				$source .= " " . $line;
				$document->next();
				$line = $document->current();
			}
			$source .= " " . $matches[ 1 ][ 0 ];
			$source = self::normalizeSource( $source );
			$sourceOptions = explode( self::DELIMITER, $source );
			$index = $sourceOptions[ 0 ];
			
			$this->setAttributeList( $index, $source );
		}
	
	}

	/**
	 *
	 * @return ArrayIterator
	 */
	public function getAnnotation( 
		$index = NULL )
	{

		if( NULL !== $index )
		{
			return $this->getAnnotation()
				->offsetGet( $index );
		}
		if( NULL === $this->annotation )
		{
			$this->setAnnotation( new \ArrayIterator() );
		}
		
		return $this->annotation;
	
	}

	/**
	 *
	 * @param \ArrayIterator $source        	
	 */
	public function setAnnotation( 
		$source )
	{

		$source = self::normalizeSource( $source );
		$this->annotation[] = $source;
		return $this;
	
	}

	/**
	 *
	 * @return \ArrayIterator
	 */
	public function getEntity( 
		$index = NULL )
	{

		if( NULL !== $index )
		{
			return $this->getEntity()
				->offsetGet( $index );
		}
		if( NULL === $this->entity )
		{
			$this->setEntity( new \ArrayIterator() );
		}
		return $this->entity;
	
	}

	public function setEntity( 
		$index, 
		$source )
	{

		$this->entity[ $index ] = $source;
		return $this;
	
	}

	/**
	 *
	 * @return \ArrayIterator
	 */
	public function getElement( 
		$index = NULL )
	{

		if( NULL !== $index )
		{
			return $this->getElement()
				->offsetGet( $index );
		}
		if( NULL === $this->element )
		{
			$this->setElement( new \ArrayIterator() );
		}
		return $this->element;
	
	}

	public function setElement( 
		$index, 
		$source )
	{

		$this->element[ $index ] = $source;
		return $this;
	
	}

	/**
	 *
	 * @return \ArrayIterator
	 */
	public function getAttributeList( 
		$index = NULL )
	{

		if( NULL !== $index )
		{
			return $this->getAttributeList()
				->offsetGet( $index );
		}
		if( NULL === $this->attributeList )
		{
			$this->setAttributeList( new \ArrayIterator() );
		}
		return $this->attributeList;
	
	}

	/**
	 *
	 * @param \ArrayIterator $attributeList        	
	 */
	public function setAttributeList( 
		$index, 
		$source )
	{

		$this->attributeList[ $index ] = $source;
		return $this;
	
	}

	/**
	 * Removes extra spaces from source
	 *
	 * @param string $source        	
	 * @return string
	 */
	public static function normalizeSource( 
		$source )
	{

		$source = trim( $source );
		while( preg_match( '/[ ]{2}/', $source ) )
		{
			$source = preg_replace( '/[\s]{2}/', ' ', $source );
		}
		return $source;
	
	}

	/**
	 * Converts Dashes to Camel Case
	 *
	 * @param string $source        	
	 * @return string
	 */
	public static function camelCase( 
		$source )
	{

		$sources = explode( "-", $source );
		$source = "";
		foreach( $sources as $string )
		{
			$source .= ucfirst( $string );
		}
		return $source;
	
	}

	/**
	 * Gets SK ITC Bundle DTD Source Document
	 *
	 * @return Document
	 */
	public function getDocument()
	{

		return $this->document;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Source Document
	 *
	 * @param Document $document
	 *        	SK ITC Bundle DTD Source Document
	 * @return \SK\ITCBundle\ORM\DTD\Source SK ITC Bundle DTD Source Document Source
	 */
	public function setDocument( 
		Document $document )
	{

		$this->document = $document;
		return $this;
	
	}

}