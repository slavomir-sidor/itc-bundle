<?php

/**
 * SK ITC Bundle Command Tests Permutation
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Service\Command\Tests;

use SK\ITCBundle\Service\Code\Generator\PHPUnit\PHPUnit;

class Permutation extends PHPUnit
{

	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Service\Code\Generator\PHPUnit\AbstractGenerator::execute($input, $output)
	 */
	public function generate()
	{

		parent::execute( $input, $output );
	
	}

}