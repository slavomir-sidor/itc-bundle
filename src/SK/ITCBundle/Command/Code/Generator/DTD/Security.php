<?php

/**
 * SK ITCBundle Command Code Generator DTD Security
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\DTD;

use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use SK\ITCBundle\Code\Generator\DTD\Security as SecurityGenerator;

class Security extends AbstractGenerator
{
	
	/**
	 * * SK ITCBundle Command Code Generator DTD Security Generator
	 *
	 * @var SecurityGenerator
	 */
	protected $generator;
	
	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\AbstractGenerator\Generator::configure()
	 */
	protected function configure()
	{
		$this->addArgument( 'output', InputArgument::OPTIONAL, 'Output Folder', 'src/AppBundle/Resource/config' );
		parent::configure();
	}
	
	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::execute()
	 */
	public function execute( InputInterface $input, OutputInterface $output )
	{
		$generator = $this->getGenerator();
	}
}