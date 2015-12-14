<?php

/**
 * SK ITC Bundle DTD Source
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Document;

abstract class Source
{
	
	/**
	 * SK ITC Bundle DTD Source Document
	 *
	 * @var Document
	 */
	protected $document;
	
	/**
	 * Constructs SK ITC Bundle DTD Source
	 *
	 * @param Document $document
	 *        	SK ITC Bundle DTD Source Document
	 */
	public function __construct( Document $document )
	{
		$this->setDocument( $document );
	}
	
	/**
	 * Abstract Reads SK ITC Bundle DTD Source
	 */
	abstract protected function read();
	
	/**
	 * Removes extra spaces from source
	 *
	 * @param string $source
	 *        	SK ITC Bundle Document Source String
	 * @return string
	 */
	public static function normalizeSource( $source )
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
	 *        	SK ITC Bundle Document Source String
	 * @return string
	 */
	public static function camelCase( $source )
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
	 * Gets SK ITC Bundle Document Source Document
	 *
	 * @return Document SK ITC Bundle Document Source Document
	 */
	public function getDocument()
	{
		return $this->document;
	}
	
	/**
	 * Sets SK ITC Bundle Document Source Document
	 *
	 * @param Document $document
	 *        	SK ITC Bundle Document Source Document
	 * @return \SK\ITCBundle\DTD\Source SK ITC Bundle Document Source
	 */
	public function setDocument( Document $document )
	{
		$this->document = $document;
		return $this;
	}
}