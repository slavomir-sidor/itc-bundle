<?php
/**
 * SK ITC Bundle Application Console
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Application;

use Symfony\Bundle\FrameworkBundle\Console\Application;
use Symfony\Component\HttpKernel\KernelInterface;

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
	 * Constructs SK ITC Bundle Application Console
	 *
	 * @param KernelInterface $kernel
	 * @param string $name
	 * @param string $version
	 */
	public function __construct( KernelInterface $kernel, $name = 'ITCloud', $version = '${project.version}' )
	{
		parent::__construct( $kernel );

		$this->setName( $name );
		$this->setVersion( $version );
	}

	/**
	 * {@inheritDoc}
	 *
	 * @see \Symfony\Component\Console\Application::getHelp()
	 */
	public function getHelp()
	{
		return self::$logo . parent::getHelp();
	}
}