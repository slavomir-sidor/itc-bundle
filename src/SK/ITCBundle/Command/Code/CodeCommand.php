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
use Symfony\Component\Finder\Finder;
use Symfony\Component\Console\Input\InputOption;

/**
 * SK ITCBundle Command Abstract
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
abstract class CodeCommand extends AbstractCommand
{

    /**
     * SK ITCBundle Command Code Generator Class Reflection
     *
     * @var ClassReflection[]
     */
    protected $classReflections;

    /**
     * SK ITCBundle Command Code Generator Source directory
     *
     * @var string[]
     */
    protected $src;

    /**
     * SK ITCBundle Command Code Generator Directory Scanner
     *
     * @var DirectoryScanner
     */
    protected $directoryScanner;

    /**
     * SK ITCBundle Command Code Generator Finder
     *
     * @var Finder
     */
    protected $finder;

    /**
     * Gets SK ITCBundle Command Code Generator Finder
     *
     * @return \Symfony\Component\Finder\Finder
     */
    protected function getFinder()
    {
        if (null === $this->finder) {
            $finder = new Finder();
            $finder->ignoreDotFiles(TRUE);
            $finder->in($this->getSrc());
            $nameSuffix = $this->getInput()->getOption("suffix");
            
            if ($this->getInput()->getOption("suffix")) {
                $finder->name('*.' . $nameSuffix);
            }
        }
        
        return $finder;
    }

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
        
        $this->addOption("suffix", "s", InputOption::VALUE_OPTIONAL, "File suffixes for given src, default all and not dot files.");
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
     * Gets SK ITCBundle Command Code Generator Class Reflection
     *
     * @return ClassReflection[]
     */
    public function getClassReflections()
    {
        if (NULL === $this->classReflections) {
            
            $this->writeLine();
            $this->writeInfo(sprintf("Processing classes in source files '%s'.", implode("|", $this->getSrc())));
            $this->writeLine();
            
            $progress = new ProgressBar($this->getOutput(), $this->getFinder()->count());
            $progress->start();
            
            /* @var $classReflections FileReflection[] */
            $classReflections = array();
            
            /* @var $exceptions \Exception[] */
            $exceptions = array();
            
            foreach ($this->getFinder()->files() as $fileName) {
                
                try {
                    $file = new FileReflection($fileName, true);
                    $fileClasses = $file->getClasses();
                    $classReflections = array_merge($classReflections, $fileClasses);
                } catch (\Exception $exception) {
                    $exceptions[] = $exception;
                }
                $progress->advance();
            }
            $this->setClassReflections($classReflections);
            
            $progress->finish();
            
            $this->writeLine();
            $this->writeInfo(sprintf("Done Processing %d Classes with %d errors.", count($exceptions), $this->getFinder()->count()));
            $this->writeLine();
            
            foreach ($exceptions as $exception) {
                $this->writeError($exception->getMessage());
            }
        }
        
        return $this->classReflections;
    }

    /**
     * Sets SK ITCBundle Command Code Generator Class Reflections
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
     * Gets SK ITCBundle Command Code Generator Class Directory Scanner
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
     * Sets SK ITCBundle Command Code Generator Class Directory Scanner
     *
     * @param DirectoryScanner $directoryScanner            
     */
    public function setDirectoryScanner(DirectoryScanner $directoryScanner)
    {
        $this->directoryScanner = $directoryScanner;
        return $this;
    }
}