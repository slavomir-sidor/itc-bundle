<?php

namespace SK\ITCBundle\Command;

use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Helper\Table;

/**
 * SK ITCBundle Command Abstract
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
abstract class AbstractCommand extends Command
{

	/**
	 * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Input
	 *
	 * @var InputInterface
	 */
	protected $input;

	/**
	 * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Output
	 *
	 * @var OutputInterface
	 */
	protected $output;

	/**
	 * SK ITCBundle Command Code Generator Exceptions
	 *
	 * @var \Exception[]
	 */
	protected $exceptions;

	/**
	 * Gets SK ITCBundle Command Code Generator Exception
	 *
	 * @return \Exception[]
	 */
	public function getExceptions()
	{

		if( null == $this->exceptions )
		{
			$this->exceptions = array();
		}
		return $this->exceptions;
	
	}

	/**
	 * Sets SK ITCBundle Command Code Generator Exception
	 *
	 * @param \Exception[] $exceptions
	 *        	SK ITCBundle Command Code Generator Exceptions
	 * @return \SK\ITCBundle\Command\Code\CodeCommand
	 */
	public function setExceptions( 
		array $exceptions )
	{

		$this->exceptions = $exceptions;
		return $this;
	
	}

	/**
	 * Adds SK ITCBundle Command Code Generator Exception
	 *
	 * @param \Exception $exception
	 *        	SK ITCBundle Command Code Generator Exception
	 * @return \SK\ITCBundle\Command\Code\CodeCommand
	 */
	public function addException( 
		\Exception $exception )
	{

		$this->exceptions[] = $exception;
		return $this;
	
	}

	/**
	 * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Option OPTION_VERBOSE_OUTPUT_YES
	 *
	 * @var string
	 */
	const OPTION_VERBOSE_OUTPUT_YES = 'yes';

	/**
	 * Constructs SK ITCBundle Command Code Abstract Reflection
	 *
	 * @param string $name
	 *        	SK ITCBundle Command Code Abstract Reflection Name
	 * @param string $description
	 *        	SK ITCBundle Command Code Abstract Reflection Description
	 */
	public function __construct( 
		$name = "src:reflect", 
		$description = "ITCloud Reflect Source Code" )
	{

		parent::__construct( $name );
		$this->setDescription( $description );
	
	}

	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::execute()
	 */
	public function execute( 
		InputInterface $input, 
		OutputInterface $output )
	{

		$this->setInput( $input );
		$this->setOutput( $output );
	
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
	 * Gets SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Input
	 *
	 * @return InputInterface
	 */
	public function getInput()
	{

		return $this->input;
	
	}

	/**
	 * Sets SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Input
	 *
	 * @param InputInterface $input        	
	 */
	public function setInput( 
		InputInterface $input )
	{

		$this->input = $input;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Output
	 *
	 * @return OutputInterface
	 */
	public function getOutput()
	{

		return $this->output;
	
	}

	/**
	 * Sets SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Output
	 *
	 * @param OutputInterface $output        	
	 */
	public function setOutput( 
		OutputInterface $output )
	{

		$this->output = $output;
		return $this;
	
	}

	public function writeError( 
		$message, 
		$verbosity = OutputInterface::VERBOSITY_NORMAL )
	{

		$output = $this->getOutput();
		$output->writeln( ' <fg=black;bg=red>Error:</fg=black;bg=red> ' . $message, $verbosity );
	
	}

	public function writeException( 
		\Exception $exception )
	{

		$this->getOutput()
			->writeln( 
			sprintf( " <fg=black;bg=red>Error %s %s</fg=black;bg=red>", $exception->getCode(), $exception->getMessage() ), 
			OutputInterface::VERBOSITY_VERBOSE );
		$this->getOutput()
			->writeln( 
			sprintf( " <fg=black;bg=red>Trace %s</fg=black;bg=red>", $exception->getTraceAsString() ), 
			OutputInterface::VERBOSITY_VERY_VERBOSE );
	
	}

	public function writeExceptions()
	{

		if( count( $this->getExceptions() ) > 0 )
		{
			$this->writeInfo( "Occured %d exceptions", count( $this->getExceptions() ) );
			foreach( $this->getExceptions() as $exception )
			{
				$this->writeException( $exception );
			}
		}
	
	}

	public function writeLine( 
		$message = "\n", 
		$verbosity = OutputInterface::VERBOSITY_NORMAL )
	{

		$output = $this->getOutput();
		$output->writeln( $message );
	
	}

	public function writeInfo( 
		$message, 
		$verbosity = OutputInterface::VERBOSITY_NORMAL )
	{

		$output = $this->getOutput();
		$output->writeln( sprintf( '<bg=green>%s</bg=green>', $message ), $verbosity );
	
	}

	public function writeHeader( 
		$message )
	{

		$output = $this->getOutput();
		$output->writeln( ' <fg=white;bg=magenta>' . $message . "</fg=white;bg=magenta>" );
	
	}

	/**
	 * Writes Given Table
	 *
	 * @param array $rows        	
	 * @param array $header        	
	 */
	public function writeTable( 
		$rows = array(), 
		$header = array(), 
		$verbosity = OutputInterface::VERBOSITY_NORMAL )
	{

		$table = new Table( $this->getOutput() );
		$table->setHeaders( $header );
		$table->setRows( $rows );
		$table->render();
	
	}

	public function writeNotice( 
		$message, 
		$verbosity = OutputInterface::VERBOSITY_NORMAL )
	{

		$this->getOutput()
			->writeln( "<fg=yellow>{$message}</fg=yellow>", $verbosity );
	
	}

	public function writeDebug( 
		$message )
	{

		$input = $this->getInput();
		$output = $this->getOutput();
		
		if( self::OPTION_VERBOSE_OUTPUT_YES == $input->getOption( "verbose" ) )
		{
			$output->writeln( ' <fg=blue;bg=white>DEBUG:</fg=blue;bg=white> ' . $message );
		}
	
	}

	/**
	 * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Root directory
	 *
	 * @var string
	 */
	protected $rootDir;

	/**
	 *
	 * @return string
	 */
	public function getRootDir()
	{

		if( NULL === $this->rootDir )
		{
			$this->setRootDir( getcwd() );
		}
		
		return $this->rootDir;
	
	}

	/**
	 *
	 * @param string $rootDir        	
	 * @return \SK\ITCBundle\Command\Tests\AbstractGenerator
	 */
	public function setRootDir( 
		$rootDir )
	{

		$this->rootDir = $rootDir;
		return $this;
	
	}

	/**
	 *
	 * @return \SystemContainer
	 */
	protected function getContainer()
	{

		return Environment::getContext();
	
	}

	/**
	 *
	 * @param string $method        	
	 * @return \Nette\mixed
	 */
	public function getEnvironmentInvokedConfig( 
		$method )
	{

		return Environment::getConfig( __NAMESPACE__ . $method, array() );
	
	}

	/**
	 *
	 * @throws Nette\InvalidStateException
	 * @param string $name        	
	 * @return string
	 */
	protected function getCacheDirectory( 
		$name = 'Boostrap' )
	{

		$directory = sprintf( "%s/cache/%s.%s", $this->getContainer()->parameters[ 'tempDir' ], str_replace( "\\", ".", __CLASS__ ), $name );
		
		if( ! is_dir( $directory ) )
		{
			mkdir( $directory, 0775, TRUE );
		}
		
		return $directory;
	
	}

}