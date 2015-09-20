<?php
/**
 * SK ITC Bundle Service Abstract XML Schema Abstract Generator
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\XMLSchema;

use SK\ITCBundle\XMLSchema\Document;
use Symfony\Component\Console\Input\InputArgument;
use SK\ITCBundle\Command\Code\Generator\GeneratorCommand;

abstract class AbstractGenerator extends GeneratorCommand
{

	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\AbstractGenerator\Generator::configure()
	 */
	protected function configure()
	{
		$this->addArgument('xsd', InputArgument::OPTIONAL, 'XSD File');
		parent::configure();
	}

	/**
	 * Gets SK ITC Bundle AbstractGenerator XML Schema Document
	 *
	 * @return Document
	 */
	public function getDocument($uri)
	{
		return new Document($uri);
	}
}