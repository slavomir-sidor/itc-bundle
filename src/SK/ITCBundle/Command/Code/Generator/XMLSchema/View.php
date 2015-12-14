<?php

/**
 * SK ITCBundle Generator XML Schema Service
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\XMLSchema;

use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Monolog\Logger;
use Symfony\Component\Console\Input\InputArgument;

class View extends AbstractGenerator
{
	
	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\Generator\XMLSchema\AbstractGenerator::configure()
	 */
	protected function configure()
	{
		$this->addArgument( 'output', InputArgument::OPTIONAL, 'Output Folder', 'src/AppBundle/XMLSchema' );
		parent::configure();
	}
	
	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::execute()
	 */
	public function execute( InputInterface $input, OutputInterface $output )
	{
		$this->getLogger()->log( Logger::INFO, "Creating XSD View Resources" );
		$xsd = $this->getDocument( $input->getArgument( "xsd" ) );
		$xsdSchema = $xsd->getSchema();
		
		$output->writeln( "Annotations:" );
		$xsdSchemaAnnotations = $xsdSchema->getAnnotation();
		foreach( $xsdSchemaAnnotations as $xsdSchemaAnnotation )
		{
			// $output->writeln($xsdSchemaAnnotations->getDocumentation()->getContent());
		}
		
		$output->writeln( "Groups:" );
		$xsdSchemaGroups = $xsdSchema->getGroup();
		foreach( $xsdSchemaGroups as $xsdSchemaGroup )
		{
			// $output->writeln($xsdSchemaGroup->getName());
		}
		$output->writeln( "" );
		$output->writeln( "------------------------------" );
		$output->writeln( "Simple Type:" );
		$output->writeln( "------------------------------" );
		$xsdSchemaSimpleTypes = $xsdSchema->getSimpleType();
		foreach( $xsdSchemaSimpleTypes as $xsdSchemaSimpleType )
		{
			$output->writeln( $xsdSchemaSimpleType->getName() );
		}
		
		$output->writeln( "" );
		$output->writeln( "------------------------------" );
		$output->writeln( "Complex Type:" );
		$output->writeln( "------------------------------" );
		$xsdSchemaComplexTypes = $xsdSchema->getComplexType();
		foreach( $xsdSchemaComplexTypes as $xsdSchemaComplexType )
		{
			// $output->writeln($xsdSchemaComplexType->getName());
		}
	}
}