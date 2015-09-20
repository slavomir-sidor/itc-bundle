<?php
namespace SK\ITCBundle\Command\Code;

use Symfony\Component\Console\Command\Command;
use SK\ITCBundle\Command\AbstractCommand;
use Symfony\Component\Console\Input\InputArgument;
use Zend\Code\Reflection\FileReflection;
use Zend\Code\Scanner\AggregateDirectoryScanner;
use Zend\Code\Scanner\DirectoryScanner;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Helper\ProgressBar;
use Zend\Code\Scanner\FileScanner;
use Zend\Code\Reflection\ClassReflection;

/**
 * SK ITCBundle Command Abstract
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
abstract class CodeCommand extends AbstractCommand
{

    /**
     * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Class Reflection
     *
     * @var ClassReflection[]
     */
    protected $classReflections;

    /**
     * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Source directory
     *
     * @var string[]
     */
    protected $src;

    /**
     * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Directory Scanner
     *
     * @var DirectoryScanner
     */
    protected $directoryScanner;

    /**
     * (non-PHPdoc)
     *
     * @see \Symfony\Component\Console\Command\Command::execute()
     */
    public function execute(InputInterface $input, OutputInterface $output)
    {
        parent::execute($input, $output);
        $this->setSrc($input->getArgument('src'));
    }

    /**
     * (non-PHPdoc)
     *
     * @see \Symfony\Component\Console\Command\Command::configure()
     */
    protected function configure()
    {
        parent::configure();
        
        $this->addArgument('src', InputArgument::IS_ARRAY, 'PHP Source directory', array(
            'src',
            'app',
            'resource'
        ));
    }

    /**
     *
     * @return the array
     */
    public function getSrc()
    {
        return $this->src;
    }

    /**
     *
     * @param array $src            
     */
    public function setSrc(array $src)
    {
        $root = $this->getRootDir();
        
        foreach ($src as $directory) {
            $directory = $root . DIRECTORY_SEPARATOR . $directory;
            
            if (file_exists($directory)) {
                $this->src[] = $directory;
            }
        }
        
        return $this;
    }

    /**
     *
     * @param string $class            
     * @return array
     */
    protected function getNamespace($class)
    {
        $names = explode("\\", $class);
        $className = array_pop($names);
        
        return array(
            
            'namespace' => implode("\\", $names),
            'class' => $className
        );
    }

    /**
     *
     * @param boolean $returnFileScanners            
     * @return $fileScanners FileScanner[]
     *        
     */
    protected function getFileScanners($returnFileScanners = TRUE)
    {
        return $this->getDirectoryScanner()->getFiles($returnFileScanners);
    }

    /**
     * Gets SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Class Reflection
     *
     * @return ClassReflection[]
     */
    public function getClassReflections()
    {
        if (NULL === $this->classReflections) {
            
            $this->writeLine();
            $this->writeInfo(sprintf("Processing classes in source files %s.", implode("|",$this->getSrc())));
            $this->writeLine();
            
            $classReflections = array();
            $fileScanners = $this->getFileScanners();
            $fileScannersCount = count($fileScanners);
            $fileScannersErrorCount = 0;
            
            $progress = new ProgressBar($this->getOutput(), $fileScannersCount);
            $progress->start();
            $exceptions = array();
            /* @var $classScanner FileScanner */
            foreach ($fileScanners as $fileScanner) {
                
                try {
                    $file = new FileReflection($fileScanner->getFile(), TRUE);
                    $fileClasses = $file->getClasses();
                    $classReflections = array_merge($classReflections, $fileClasses);
                } catch (\Exception $e) {
                    $exceptions[] = $e;
                    ++ $fileScannersErrorCount;
                }
                
                $progress->advance();
            }
            $this->setClassReflections($classReflections);
            $progress->finish();
            
            $this->writeLine();
            $this->writeInfo(sprintf("Done Processing %d Classes with %d errors.", $fileScannersCount, $fileScannersErrorCount));
            $this->writeLine();
            
            foreach ($exceptions as $exception) {
                $this->writeError($e->getTraceAsString());
            }
        }
        
        return $this->classReflections;
    }

    /**
     * Sets SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Class Reflections
     *
     * @param ClassReflection[] $classReflections            
     * @return \SK\ITCBundle\Command\Tests\AbstractGenerator
     */
    public function setClassReflections($classReflections)
    {
        $this->classReflections = $classReflections;
        return $this;
    }

    /**
     * Gets SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Class Directory Scanner
     *
     * @return DirectoryScanner
     */
    public function getDirectoryScanner()
    {
        if (NULL === $this->directoryScanner) {
            try {
                $directoryScanner = new AggregateDirectoryScanner($this->getSrc());
                $this->setDirectoryScanner($directoryScanner);
            } catch (\Exception $e) {
                $this->writeError($e->getMessage());
            }
        }
        return $this->directoryScanner;
    }

    /**
     * Sets SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Class Directory Scanner
     *
     * @param DirectoryScanner $directoryScanner            
     */
    public function setDirectoryScanner(DirectoryScanner $directoryScanner)
    {
        $this->directoryScanner = $directoryScanner;
        return $this;
    }
}