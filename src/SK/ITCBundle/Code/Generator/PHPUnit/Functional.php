<?php

/**
 * SK ITCBundle Code Generator PHPUnit Functional
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Code\Generator\PHPUnit;

use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class Functional extends PHPUnit
{
	
	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\Generator\PHPUnit\AbstractGenerator::execute($input, $output)
	 */
	public function generate()
	{
		parent::execute( $input, $output );
		$this->generateClassFunctionalCase( $input, $output );
	}
}