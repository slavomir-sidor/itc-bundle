<?php

/**
 * SK ITCBundle Command Code Generator PHPUnit Permutation
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\PHPUnit;

use SK\ITCBundle\Command\Code\Generator\PHPUnit\PHPUnit;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class Permutation extends PHPUnitGenerator
{
	/**
	 *
	 * @param string $name        	
	 * @param string $description        	
	 */
	public function __construct( $name = "phpunit:permutation", $description = "PHPUnit Paramameters Permutation Generator" )
	{
		parent::__construct( $name, $description );
	}
	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::configure()
	 */
	protected function configure()
	{
		parent::configure();
	}
	
	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::execute()
	 */
	public function execute( InputInterface $input, OutputInterface $output )
	{
		parent::execute( $input, $output );
	}
}