<?php

/**
 * SK ITC Bundle Service Abstract DTD Abstract Generator
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Code\Generator\DTD;

use SK\ITCBundle\DTD\Document;
use SK\ITCBundle\Code\Generator\CodeGenerator;

abstract class AbstractGenerator extends CodeGenerator
{

	/**
	 * * SK ITC Bundle Code Abstract DTD Abstract Generator Document
	 *
	 * @var Document
	 */
	protected $document;

	/**
	 * Gets SK ITC Bundle Service Abstract DTD Abstract Generator Document
	 *
	 * @return Document
	 */
	public function getDocument( 
		$uri )
	{

		return new Document( $uri );
	
	}

}