<?php

/**
 * SK ITCBundle Service Abstract Generator WSDL Generator
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Service\Code\Generator\WSDL;

use SK\ITCBundle\Service\WSDL\Document;
use SK\ITCBundle\Service\Code\Generator\CodeGenerator;

abstract class AbstractGenerator extends CodeGenerator
{

	/**
	 * SK ITCBundle Service Abstract Generator WSDL Generator Document
	 *
	 * @var Document
	 */
	protected $document;

	/**
	 * Gets SK ITCBundle Service Abstract Generator WSDL Generator Document
	 *
	 * @return Document
	 */
	public function getDocument( 
		$uri )
	{

		return new Document( $uri );
	
	}

}