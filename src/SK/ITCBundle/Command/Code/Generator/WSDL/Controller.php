<?php

/**
 * SK ITCBundle Command Code Generator WSDL Controller
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\WSDL;

use SK\ITCBundle\Command\Code\Generator\WSDL\AbstractGenerator;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Monolog\Logger;

class Controller extends AbstractGenerator
{
	
	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\Generator\WSDL\Generator::configure()
	 */
	protected function configure()
	{
		$this->addOption( "controllerClass", "controller", InputOption::VALUE_OPTIONAL, "SOAP Client Class", 'SK\\ITCBundle\\Controller\\AbstractController' );
		parent::configure();
	}
	public function execute( InputInterface $input, OutputInterface $output )
	{
		$this->getLogger()->log( Logger::INFO, "Creating WSDL Controllers" );
		$wsdl = $this->getWsdlDocument( $input->getArgument( "wsdl" ) );
		$definition = $wsdl->getDefinitions();
		$portTypes = $definition->getPortType();
	}
}