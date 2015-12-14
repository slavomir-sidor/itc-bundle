<?php

/**
 * SK ITCBundle Generator Wsdl ORM
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Code\Generator\WSDL;

use SK\ITCBundle\Code\Generator\WSDL\AbstractGenerator;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class ORM extends AbstractGenerator
{
	
	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\AbstractGenerator\Generator::configure()
	 */
	protected function configure()
	{
		parent::configure();
		
		$this->addArgument( 'namespace', InputArgument::OPTIONAL, 'Namespace Name', 'AppBundle\\DTD\\Document' );
		$this->addArgument( 'parentClass', InputArgument::OPTIONAL, 'Entity Generalized Class', '\\SK\\ITCBundle\\DTD\\Document' );
		$this->addArgument( 'output', InputArgument::OPTIONAL, 'Output Folder', 'src/AppBundle/DTD/Document' );
	}
	
	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::execute()
	 */
	public function execute( InputInterface $input, OutputInterface $output )
	{
		// $this->config = $config;
		$this->log( 'Starting generation' );
		
		$options = $this->config->get( 'soapClientOptions' );
		if( empty( $options[ 'features' ] ) || (($options[ 'features' ] & SOAP_SINGLE_ELEMENT_ARRAYS) != SOAP_SINGLE_ELEMENT_ARRAYS) )
		{
			$message = array( 
					'SoapClient option feature SOAP_SINGLE_ELEMENT_ARRAYS is not set.',
					'This is not recommended as data types in DocBlocks for array properties will not be ',
					'valid if the array only contains a single value.' 
			);
			$this->log( implode( PHP_EOL, $message ), 'warning' );
		}
		
		$wsdl = $this->config->get( 'inputFile' );
		if( is_array( $wsdl ) )
		{
			foreach( $wsdl as $ws )
			{
				$this->load( $ws );
			}
		} else
		{
			$this->load( $wsdl );
		}
		
		$types = $this->wsdl->getTypes();
		$outputDir = $this->config->get( 'outputDir' );
		if( ! file_exists( $outputDir ) )
		{
			mkdir( $outputDir, 0777, true );
		}
		$namespaceName = $this->config->get( "namespaceName" );
		
		foreach( $types as $type )
		{
			print_r( $type );
			$name = $type->getName();
			$dom = new \DOMDocument();
			
			$doctrineMapping = $dom->createElementNS( "http://doctrine-project.org/schemas/orm/doctrine-mapping", "doctrine-mapping" );
			// $doctrineMapping->setAttributeNS('http://gediminasm.org/schemas/orm/doctrine-extensions-mapping',
			// 'xmlns:gedmo', 'http://gediminasm.org/schemas/orm/doctrine-extensions-mapping');
			
			$entity = $dom->createElement( "entity" );
			$entityName = ucfirst( $type->getName() );
			$entityNamespaceName = sprintf( "%s\\%s", $namespaceName, $entityName );
			
			$entity->setAttribute( "name", $entityNamespaceName );
			$entity->setAttribute( "table", $entityName );
			
			$entityId = $dom->createElement( "id" );
			$entityId->setAttribute( "name", "id" );
			$entityId->setAttribute( "type", "integer" );
			
			$entityiDGenerator = $dom->createElement( "generator" );
			$entityiDGenerator->setAttribute( "strategy", "AUTO" );
			$entityId->appendChild( $entityiDGenerator );
			$entity->appendChild( $entityId );
			
			$doctrineMapping->appendChild( $entity );
			
			$dom->appendChild( $doctrineMapping );
			$dom->formatOutput = true;
			
			$entityFilename = sprintf( "%s/%s.orm.xml", $outputDir, $entityName );
			$dom->save( $entityFilename );
		}
		
		$this->log( 'Generation complete', 'info' );
	}
}