<?php
/**
 * SK ITCBundle Command Code Generator PHPUnit Config
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\PHPUnit;

use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class Config extends PHPUnitGenerator
{

	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Command\Tests\Generate::execute($input, $output)
	 */
	public function execute( InputInterface $input, OutputInterface $output )
	{
		parent::execute( $input, $output );

		$this->generateConfigCase( $input, $output );
		$this->generateConfigServices( $input, $output );
	}
}