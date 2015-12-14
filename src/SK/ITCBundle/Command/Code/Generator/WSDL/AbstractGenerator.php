<?php

/**
 * SK ITCBundle Service Abstract Generator WSDL Generator
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\WSDL;

use SK\ITCBundle\SOAP\Client;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputOption;
use SK\ITCBundle\WSDL\Document;
use SK\ITCBundle\Command\Code\Generator\GeneratorCommand;

abstract class AbstractGenerator extends GeneratorCommand
{
	
	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\AbstractGenerator\Generator::configure()
	 */
	protected function configure()
	{
		$this->addArgument( 'wsdl', InputArgument::OPTIONAL, 'WSDL File' );
		$this->addOption( "clientClass", "client", InputOption::VALUE_OPTIONAL, "WSDL SOAP Client Class", 'SK\\ITCBundle\SOAP\\Client' );
		$this->addOption( "serverClass", "server", InputOption::VALUE_OPTIONAL, "WSDL SOAP Server Class", 'SK\\ITCBundle\SOAP\\Server' );
		$this->addOption( "namespace", "namespace", InputOption::VALUE_OPTIONAL, "WSDL SOAP Class Namespace", 'AppBundle' );
		parent::configure();
	}
	
	/**
	 * Gets SK ITCBundle Service Abstract Generator WSDL Generator Document
	 *
	 * @return Document
	 */
	public function getWsdlDocument( $uri )
	{
		return new Document( $uri );
	}
}