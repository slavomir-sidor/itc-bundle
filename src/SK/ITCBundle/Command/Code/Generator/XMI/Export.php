<?php

/**
 * SK ITCBundle Command Code Generator XMI Export
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\XMI;

use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use SK\ITCBundle\Command\Code\Generator\GeneratorCommand;

class Export extends GeneratorCommand
{

	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::configure()
	 */
	protected function configure()
	{
		$this->addArgument( 'input', InputArgument::OPTIONAL, 'Input File' );
		$this->addArgument( 'dest', InputArgument::OPTIONAL, 'Output Folder', 'src/AppBUndle/Resource/UML' );
		$this->addArgument( 'name', InputArgument::OPTIONAL, 'Name', 'Default' );

		parent::configure();
	}

	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::execute()
	 */
	public function execute( InputInterface $input, OutputInterface $output )
	{
		$source = $input->getArgument( 'input' );
		$dest = $input->getArgument( 'dest' );
		$name = $input->getArgument( 'name' );
		try
		{
			require_once 'PHP/UML.php';
			$uml = new \PHP_UML();
			$uml->setInput( $source );
			$uml->parse( $name );
			$uml->export( 'xmi', $dest );
		}
		catch( Exception $e )
		{
			$output->writeln( 'Error!' );
			$output->writeln( $e->getMessage() );
		}
	}
}