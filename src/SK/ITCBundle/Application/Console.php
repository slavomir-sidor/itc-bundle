<?php

/**
 * SK ITC Bundle Application Console
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 *
 */
namespace SK\ITCBundle\Application;

use Symfony\Component\Console\Application;

/**
 *
 * @author jahman
 *
 */
class Console extends Application
{

	private static $logo = '

IIIIIIIIIITTTTTTTTTTTTTTTTTTTTTTT       CCCCCCCCCCCCC
I::::::::IT:::::::::::::::::::::T    CCC::::::::::::C
I::::::::IT:::::::::::::::::::::T  CC:::::::::::::::C
II::::::IIT:::::TT:::::::TT:::::T C:::::CCCCCCCC::::C
  I::::I  TTTTTT  T:::::T  TTTTTTC:::::C       CCCCCC
  I::::I          T:::::T       C:::::C
  I::::I          T:::::T       C:::::C
  I::::I          T:::::T       C:::::C
  I::::I          T:::::T       C:::::C
  I::::I          T:::::T       C:::::C
  I::::I          T:::::T       C:::::C
  I::::I          T:::::T        C:::::C       CCCCCC
II::::::II      TT:::::::TT       C:::::CCCCCCCC::::C
I::::::::I      T:::::::::T        CC:::::::::::::::C
I::::::::I      T:::::::::T          CCC::::::::::::C
IIIIIIIIII      TTTTTTTTTTT             CCCCCCCCCCCCC






                                                     ';

	/**
	 *
	 * {@inheritDoc}
	 *
	 * @see \Symfony\Component\Console\Application::__construct()
	 */
	public function __construct(
		$name = 'ITCloud',
		$version = '${project.version}' )
	{

		parent::__construct( $name, $version );

		$this->add( new \SK\ITCBundle\Command\Google\Translator() );

		$this->add( new \SK\ITCBundle\Command\Code\Generator\PHPUnit\Config() );
		$this->add( new \SK\ITCBundle\Command\Code\Generator\PHPUnit\Equal() );
		$this->add( new \SK\ITCBundle\Command\Code\Generator\PHPUnit\Functional() );
		$this->add( new \SK\ITCBundle\Command\Code\Generator\PHPUnit\Performance() );
		$this->add( new \SK\ITCBundle\Command\Code\Generator\PHPUnit\Permutation() );
		$this->add( new \SK\ITCBundle\Command\Code\Generator\PHPUnit\Run() );

		// $this->add ( new \SK\ITCBundle\Command\Code\Generator\DockBlock\DocBlockCommand() );

		$this->add( new \SK\ITCBundle\Command\Code\Reflection\AttributesCommand() );
		$this->add( new \SK\ITCBundle\Command\Code\Reflection\ClassCommand() );
		$this->add( new \SK\ITCBundle\Command\Code\Reflection\FilesCommand() );
		$this->add( new \SK\ITCBundle\Command\Code\Reflection\NamespaceCommand() );
		$this->add( new \SK\ITCBundle\Command\Code\Reflection\OperationsCommand() );
		$this->add( new \SK\ITCBundle\Command\Code\Reflection\OperationsAttributesCommand() );

		// $this->add ( new \SK\ITCBundle\Command\Code\Reflection\BundleCommand () );
	}

	public function getHelp()
	{

		return self::$logo . parent::getHelp();

	}

}