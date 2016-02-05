<?php
/**
 * SK ITCBundle Command Code REST Abstract Command
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\REST;

use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputArgument;
use Monolog\Logger;
use SK\ITCBundle\Code\Reflection;
use SK\ITCBundle\Command\TableCommand;
use Raml\Parser;
use Raml\ApiDefinition;
use Symfony\Component\Console\Input\InputOption;

abstract class RESTCommand extends TableCommand
{

	/**
	 *
	 * @var Parser
	 */
	protected $apiParser;

	/**
	 *
	 * @var ApiDefinition
	 */
	protected $apiDefinition;

	/**
	 * Constructs SK ITCBundle Abstract Command
	 *
	 * @param string $name
	 *        	SK ITCBundle Abstract Command Name
	 * @param string $description
	 *        	SK ITCBundle Abstract Command Description
	 * @param Logger $logger
	 *        	SK ITCBundle Abstract Command Logger
	 * @param Reflection $reflection
	 *        	SK ITCBundle Abstract Command Reflection
	 * @param Parser $apiParser
	 */
	public function __construct( $name, $description, Logger $logger, Reflection $reflection, Parser $apiParser )
	{
		parent::__construct( $name, $description, $logger, $reflection );

		$this->setApiParser( $apiParser );
	}

	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\Generator\PHPUnit\AbstractGenerator::execute($input, $output)
	 */
	public function execute( InputInterface $input, OutputInterface $output )
	{
		parent::execute( $input, $output );

		$this->writeTable( 50 );
	}

	/**
	 *
	 * {@inheritDoc}
	 *
	 * @see \SK\ITCBundle\Command\AbstractCommand::configure()
	 */
	protected function configure()
	{
		parent::configure();

		$outputDirectory = $_SERVER['PWD'] . DIRECTORY_SEPARATOR . 'src';
		$this->addOption( "namespace", "ns", InputOption::VALUE_OPTIONAL, "REST API Target namespace.", "\\" );
		$this->addOption( "outputDirectory", "o", InputOption::VALUE_OPTIONAL, "REST API Target namespace.", $outputDirectory );

		$this->addArgument( 'raml', InputArgument::REQUIRED, 'RAML Source file' );
	}

	/**
	 *
	 * @return Parser
	 */
	protected function getApiParser()
	{
		return $this->apiParser;
	}

	/**
	 *
	 * @param Parser $apiParser
	 */
	protected function setApiParser( Parser $apiParser )
	{
		$this->apiParser = $apiParser;
		return $this;
	}

	/**
	 *
	 * @return ApiDefinition
	 */
	protected function getApiDefinition()
	{
		if( null === $this->apiDefinition )
		{
			$filename = $this->getInput()->getArgument( 'raml' );
			$parser = $this->getApiParser();
			$apiDefinition = $parser->parse( $filename );
			$this->setApiDefinition( $apiDefinition );
		}

		return $this->apiDefinition;
	}

	/**
	 *
	 * @param ApiDefinition $apiDefinition
	 */
	protected function setApiDefinition( ApiDefinition $apiDefinition )
	{
		$this->apiDefinition = $apiDefinition;
		return $this;
	}
}