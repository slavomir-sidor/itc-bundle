<?php

/**
 * SK ITCBundle Generator XML Schema ORM
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\XMLSchema;

use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Input\InputArgument;

class ORM extends AbstractGenerator
{

	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\AbstractGenerator\Generator::configure()
	 */
	protected function configure()
	{

		$this->addArgument( 'namespace', InputArgument::OPTIONAL, 'Namespace Name', 'AppBundle\\DTD\\Document' );
		$this->addArgument( 'parentClass', InputArgument::OPTIONAL, 'Entity Generalized Class', '\\SK\\ITCBundle\\DTD\\Document' );
		$this->addArgument( 'output', InputArgument::OPTIONAL, 'Output Folder', 'src/AppBundle/DTD/Document' );
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