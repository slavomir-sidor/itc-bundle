<?php

/**
 * SK ITC Bundle Code Generator XML Schema
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Service\Code\Generator\XMLSchema;

use SK\ITCBundle\Service\XMLSchema\Document;
use Symfony\Component\Console\Input\InputArgument;
use SK\ITCBundle\Service\Code\Generator\CodeGenerator;

abstract class AbstractGenerator extends CodeGenerator
{

	/**
	 * SK ITC Bundle Code Generator XML Schema Document
	 *
	 * @var Document
	 */
	protected $document;

	/**
	 * Gets SK ITC Bundle Code Generator XML Schema Document
	 *
	 * @return Document
	 */
	public function getDocument( 
		$uri )
	{

		return new Document( $uri );
	
	}

}