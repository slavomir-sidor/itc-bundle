<?php

/**
 * SK ITCBundle Google Translator
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Google;

use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Input\InputArgument;
use SK\ITCBundle\Command\AbstractCommand;

class Translator extends AbstractCommand
{
	public function __construct( $name = "trans:google", $description = "Google Translator" )
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
		$this->addArgument( 'text', InputArgument::REQUIRED, 'Text' );
		$this->addArgument( 'from', InputArgument::REQUIRED, 'Locale From' );
		$this->addArgument( 'to', InputArgument::REQUIRED, 'Locale to' );
	}
	
	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::execute()
	 */
	public function execute( InputInterface $input, OutputInterface $output )
	{
		$translator = $this->getContainer()->get( 'sk.itcbundle.google.translator' );
		$text = $input->getArgument( 'text' );
		$from = $input->getArgument( 'from' );
		$to = $input->getArgument( 'to' );
		$text = $translator->translate( $text, $from, $to );
		$output->writeln( $text );
	}
}