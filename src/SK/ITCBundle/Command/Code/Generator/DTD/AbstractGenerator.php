<?php

/**
 * SK ITC Bundle Service Abstract DTD Abstract Generator
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\DTD;

use SK\ITCBundle\DTD\Document;
use Symfony\Component\Console\Input\InputArgument;
use SK\ITCBundle\Command\Code\Generator\GeneratorCommand;

abstract class AbstractGenerator extends GeneratorCommand
{

	/**
	 * * SK ITC Bundle Code Abstract DTD Abstract Generator Document
	 *
	 * @var Document
	 */
	protected $document;

	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\Generator\AbstractGenerator::configure()
	 */
	protected function configure()
	{

		$this->addArgument( 'document', InputArgument::OPTIONAL, 'DTD File ' );
		parent::configure();
	
	}

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