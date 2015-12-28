<?php

/**
 * SK ITCBundle Command Code Reflection Files
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Reflection;

use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class FilesCommand extends ReflectionCommand
{

	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\Generator\PHPUnit\AbstractGenerator::execute($input, $output)
	 */
	public function execute( InputInterface $input, OutputInterface $output )
	{
		parent::execute( $input, $output );

		$this->writeTable( $this->getFiles(), array(
			"Files",
			"Owner",
			"Group",
			"Permissions",
			"Created",
			"Modified"
		), 120 );
	}
}