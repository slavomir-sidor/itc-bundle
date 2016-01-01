<?php
/**
 * SK ITCBundle Command Code Reflection Classes
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Reflection;

use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class ClassesCommand extends ReflectionCommand
{

	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\Generator\PHPUnit\AbstractGenerator::execute($input, $output)
	 */
	public function execute( InputInterface $input, OutputInterface $output )
	{
		parent::execute( $input, $output );

		$this->writeTable( $this->getClasses(), array(
			'PHP Object',
			'Final',
			'Abstract',
			'Namespace Name',
			'Parent',
			'Implements Interfaces'
		), 60 );
	}
}