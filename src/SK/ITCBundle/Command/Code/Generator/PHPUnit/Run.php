<?php

/**
 * SK ITCBundle Command Code Generator PHPUnit Run
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\PHPUnit;

define( 'PHPUnit_MAIN_METHOD', 'PHPUnit_TextUI_Command::main' );

use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class Run extends PHPUnitGenerator
{

	/**
	 *
	 * @param string $name        	
	 * @param string $description        	
	 */
	public function __construct( 
		$name = "phpunit:run", 
		$description = "PHPUnit Run" )
	{

		parent::__construct( $name, $description );
	
	}

	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\Generator\PHPUnit\AbstractGenerator::configure()
	 */
	protected function configure()
	{

		parent::configure();
	
	}

	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\Generator\PHPUnit\AbstractGenerator::execute($input, $output)
	 */
	public function execute( 
		InputInterface $input, 
		OutputInterface $output )
	{

		$this->writeHeader( $output );
		
		if( strpos( '/usr/bin/php', '@php_bin' ) === 0 )
		{
			require dirname( __FILE__ ) . DIRECTORY_SEPARATOR . 'PHPUnit' . DIRECTORY_SEPARATOR . 'Autoload.php';
		}
		else
		{
			require '/usr/share/pear' . DIRECTORY_SEPARATOR . 'PHPUnit' . DIRECTORY_SEPARATOR . 'Autoload.php';
		}
		
		$commandArg = array( 
			
			'-c' => "phpunit.xml" 
		);
		
		$command = new \PHPUnit_TextUI_Command();
		$command->run( $commandArg );
	
	}

}