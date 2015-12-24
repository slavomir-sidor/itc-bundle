<?php

/**
 * SK ITCBundle Command Code Generator DTD Attribute List
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\DTD;

use Monolog\Logger;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Formatter\OutputFormatter;
use Symfony\Component\Console\Helper\ProgressBar;
use Zend\Code\Reflection\ClassReflection;
use Zend\Code\Reflection\FileReflection;
use Zend\Code\Generator\FileGenerator;
use Zend\Code\Generator\ClassGenerator;
use Zend\Code\Generator\DocBlockGenerator;
use Zend\Code\Generator\PropertyGenerator;
use Zend\Code\Generator\DocBlock\Tag;
use SK\ITCBundle\DTD\Source;
use SK\ITCBundle\Code\Generator\DTD\AttributeList as AttributeListGenerator;

class AttributeList extends AbstractGenerator
{

	/**
	 * SK ITCBundle Command Code Generator DTD Attribute List Generator
	 *
	 * @var AttributeListGenerator
	 */
	protected $generator;

	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\AbstractGenerator\Generator::configure()
	 */
	protected function configure()
	{

		$this->addArgument( 'attlistNamespace', InputArgument::OPTIONAL, 'Namespace Name', 'AppBundle\\DTD\\AttributeList' );
		$this->addArgument( 'attlistParentClass', InputArgument::OPTIONAL, 'Entity Generalized Class', '\\SK\\ITCBundle\\DTD\\%s\\AttributeList' );
		$this->addArgument( 'attlistOutput', InputArgument::OPTIONAL, 'Output Folder', 'src/AppBundle/DTD/%s/AttributeList' );
		parent::configure();
	
	}

	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::execute()
	 */
	public function execute( 
		InputInterface $input, 
		OutputInterface $output )
	{

	
	}

}