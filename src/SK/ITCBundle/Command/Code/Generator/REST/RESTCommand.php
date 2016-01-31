<?php
/**
 * SK ITCBundle Command Code REST Abstract Command
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\REST;

use SK\ITCBundle\Command\Code\Reflection\ReflectionCommand;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputArgument;

abstract class RESTCommand extends ReflectionCommand
{

	protected $apiParser;

	protected $apiDefinition;

	/**
	 *
	 * {@inheritDoc}
	 *
	 * @see \SK\ITCBundle\Command\AbstractCommand::configure()
	 */
	protected function configure()
	{
		parent::configure();

		$srcArgument = $this->getDefinition()->getArgument( "src" );
		$srcArgument->setDefault( array(
			'.'
		) );
	}

	/**
	 *
	 * {@inheritDoc}
	 *
	 * @see \SK\ITCBundle\Command\AbstractCommand::execute()
	 */
	public function execute( InputInterface $input, OutputInterface $output )
	{
		parent::execute( $input, $output );
	}
}