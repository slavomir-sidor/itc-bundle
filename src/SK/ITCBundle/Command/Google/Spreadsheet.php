<?php

/**
 * SK ITCBundle Google Translator
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Google;

use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use SK\ITCBundle\Command\AbstractCommand;
use Symfony\Bridge\Monolog\Logger;
use SK\ITCBundle\Service\Table\Table;

class Spreadsheet extends AbstractCommand
{

	public function __construct( $name, $description, Logger $logger, Table $table )
	{
		parent::__construct( $name, $description, $logger, $table );
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
	{}
}