<?php

/**
 * SK ITCBundle Code Generator WSDL Controller
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Service\Code\Generator\WSDL;

use SK\ITCBundle\Service\Code\Generator\WSDL\AbstractGenerator;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Monolog\Logger;

class Controller extends AbstractGenerator
{

	/**
	 * (non-PHPdoc)
	 *
	 * @see \Zend\Code\Generator\GeneratorInterface::generate()
	 */
	public function generate( 
		Document $document )
	{

		$definition = $document->getDefinitions();
		$portTypes = $definition->getPortType();
	
	}

}