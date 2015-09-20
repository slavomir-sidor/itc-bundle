<?php
namespace SK\ITCBundle\Console;

use Symfony\Component\Console\Application;

/**
 *
 * @author jahman
 *        
 */
class ITCApplication extends Application
{
    
    private static $logo = '                                                                                                                    
                                                                                                            dddddddd
IIIIIIIIIITTTTTTTTTTTTTTTTTTTTTTT       CCCCCCCCCCCCClllllll                                                d::::::d
I::::::::IT:::::::::::::::::::::T    CCC::::::::::::Cl:::::l                                                d::::::d
I::::::::IT:::::::::::::::::::::T  CC:::::::::::::::Cl:::::l                                                d::::::d
II::::::IIT:::::TT:::::::TT:::::T C:::::CCCCCCCC::::Cl:::::l                                                d:::::d 
  I::::I  TTTTTT  T:::::T  TTTTTTC:::::C       CCCCCC l::::l    ooooooooooo   uuuuuu    uuuuuu      ddddddddd:::::d 
  I::::I          T:::::T       C:::::C               l::::l  oo:::::::::::oo u::::u    u::::u    dd::::::::::::::d 
  I::::I          T:::::T       C:::::C               l::::l o:::::::::::::::ou::::u    u::::u   d::::::::::::::::d 
  I::::I          T:::::T       C:::::C               l::::l o:::::ooooo:::::ou::::u    u::::u  d:::::::ddddd:::::d 
  I::::I          T:::::T       C:::::C               l::::l o::::o     o::::ou::::u    u::::u  d::::::d    d:::::d 
  I::::I          T:::::T       C:::::C               l::::l o::::o     o::::ou::::u    u::::u  d:::::d     d:::::d 
  I::::I          T:::::T       C:::::C               l::::l o::::o     o::::ou::::u    u::::u  d:::::d     d:::::d 
  I::::I          T:::::T        C:::::C       CCCCCC l::::l o::::o     o::::ou:::::uuuu:::::u  d:::::d     d:::::d 
II::::::II      TT:::::::TT       C:::::CCCCCCCC::::Cl::::::lo:::::ooooo:::::ou:::::::::::::::uud::::::ddddd::::::dd
I::::::::I      T:::::::::T        CC:::::::::::::::Cl::::::lo:::::::::::::::o u:::::::::::::::u d:::::::::::::::::d
I::::::::I      T:::::::::T          CCC::::::::::::Cl::::::l oo:::::::::::oo   uu::::::::uu:::u  d:::::::::ddd::::d
IIIIIIIIII      TTTTTTTTTTT             CCCCCCCCCCCCCllllllll   ooooooooooo       uuuuuuuu  uuuu   ddddddddd   ddddd
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    ';
    /**
     *
     * {@inheritDoc}
     *
     * @see \Symfony\Component\Console\Application::__construct()
     */
    public function __construct($name = 'ITC', $version = '0.0.20')
    {
        parent::__construct($name, $version);
        
        $this->add ( new \SK\ITCBundle\Command\Google\Translator () );
        
        $this->add ( new \SK\ITCBundle\Command\Code\Generator\PHPUnit\Config () );
        $this->add ( new \SK\ITCBundle\Command\Code\Generator\PHPUnit\Equal () );
        $this->add ( new \SK\ITCBundle\Command\Code\Generator\PHPUnit\Functional () );
        $this->add ( new \SK\ITCBundle\Command\Code\Generator\PHPUnit\Performance () );
        $this->add ( new \SK\ITCBundle\Command\Code\Generator\PHPUnit\Permutation() );
        $this->add ( new \SK\ITCBundle\Command\Code\Generator\PHPUnit\Run() );
        
        //$this->add ( new \SK\ITCBundle\Command\Code\Generator\DockBlock\DocBlockCommand() );
        
        $this->add ( new \SK\ITCBundle\Command\Code\Reflection\AttributesCommand() );
        $this->add ( new \SK\ITCBundle\Command\Code\Reflection\ClassCommand() );
        $this->add ( new \SK\ITCBundle\Command\Code\Reflection\DocBlockCommand() );
        $this->add ( new \SK\ITCBundle\Command\Code\Reflection\FilesCommand() );
        $this->add ( new \SK\ITCBundle\Command\Code\Reflection\NamespaceCommand () );
        $this->add ( new \SK\ITCBundle\Command\Code\Reflection\OperationsCommand() );
        $this->add ( new \SK\ITCBundle\Command\Code\Reflection\OperationsAttributesCommand() );
        
        //$this->add ( new \SK\ITCBundle\Command\Code\Reflection\BundleCommand () );
        
    }

    public function getHelp()
    {
        return self::$logo . parent::getHelp();
    }
}