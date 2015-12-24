<?php

/**
 * SK ITCBundle Command Code Generator PHPUnit Equal
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\PHPUnit;

use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class Equal extends PHPUnitGenerator
{

	/**
	 *
	 * @param string $name        	
	 * @param string $description        	
	 */
	public function __construct( 
		$name = "phpunit:equal", 
		$description = "PHPUnit Equal tests" )
	{

		parent::__construct( $name, $description );
	
	}

	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\Generator\PHPUnit\AbstractGenerator::configure()
	 */
	protected function configure()
	{

		parent::configure();
	
	}

	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\Generator\PHPUnit\AbstractGenerator::execute($input, $output)
	 */
	public function execute( 
		InputInterface $input, 
		OutputInterface $output )
	{

		parent::execute( $input, $output );
		$this->generateClassEqualCase( $input, $output );
	
	}

}