<?php
namespace SK\ITCBundle\Command\Code;

use Symfony\Component\Console\Command\Command;
use SK\ITCBundle\Command\AbstractCommand;
use Symfony\Component\Console\Input\InputArgument;
use Zend\Code\Reflection\FileReflection;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Helper\ProgressBar;
use Symfony\Component\Finder\Finder;
use Symfony\Component\Console\Input\InputOption;
use TokenReflection\Broker;
use TokenReflection\ReflectionFile;
use TokenReflection\ReflectionClass;
use TokenReflection\Broker\Backend;

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
     * @var ReflectionClass[]
     */
    protected $classReflections;

    /**
     * SK ITCBundle Command Code Generator Source directory
     *
     * @var string[]
     */
    protected $src;

    /**
     * SK ITCBundle Command Code Generator Finder
     *
     * @var Finder
     */
    protected $finder;

    /**
     * SK ITCBundle Command Code Generator Broker
     *
     * @var Broker
     */
    protected $broker;

    /**
     * Gets SK ITCBundle Command Code Generator Broker
     *
     * @return \TokenReflection\Broker
     */
    public function getBroker()
    {
        if (null === $this->broker) {
            $broker = new Broker(new Broker\Backend\Memory());
            $this->setBroker($broker);
        }
        return $this->broker;
    }

    /**
     * Gets SK ITCBundle Command Code Generator Finder
     *
     * @return \Symfony\Component\Finder\Finder
     */
    public function getFinder()
    {
        if (null === $this->finder) {
            $finder = new Finder();
            $finder->ignoreDotFiles(TRUE);
            $finder->in($this->getSrc());
            $nameSuffix = $this->getInput()->getOption("suffix");
            
            if ($this->getInput()->getOption("suffix")) {
                $finder->name('*.' . $nameSuffix);
            }
            
            $this->setFinder($finder);
            $this->writeInfo(sprintf("Found %d files.", $this->getFinder()
                ->count()));
        }
        
        return $this->finder;
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
        $this->addOption("parentClass", "pc", InputOption::VALUE_OPTIONAL, "Parent Class filter.");
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
     * Gets SK ITCBundle Command Code Generator Class Reflection
     *
     * @return ReflectionClass[]
     */
    public function getClassReflections()
    {
        if (NULL === $this->classReflections) {
            $progress = new ProgressBar($this->getOutput(), $this->getFinder()->count());
            $progress->start();
            
            /* @var $classReflections ReflectionClass[] */
            $classReflections = array();
            
            /* @var $exceptions \Exception[] */
            $exceptions = array();
            
            foreach ($this->getFinder()->files() as $fileName) {
                try {
                    /* @var $fileReflection ReflectionFile */
                    $fileReflection = $this->getBroker()->processFile($fileName);
                } catch (\Exception $exception) {
                    $this->addException($exception);
                }
                $progress->advance();
            }
            $progress->finish();
            
            $classReflections = $this->getBroker()->getClasses(Backend::TOKENIZED_CLASSES, Backend::INTERNAL_CLASSES);
            $parentClass = $this->getInput()->getOption("parentClass");
            
            if ($parentClass) {
                
                foreach ($classReflections as $key=>$classReflection) {
                    if(!in_array($parentClass, $classReflection->getParentClassNameList())){
                        unset($classReflections[$key]);
                    }
                }
            }
            $this->setClassReflections($classReflections);
            
            $this->writeInfo(sprintf("Found %d Classes with %d errors.", count($this->getClassReflections()), count($this->getExceptions())));
        }
        
        return $this->classReflections;
    }

    /**
     * Sets SK ITCBundle Command Code Generator Class Reflections
     *
     * @param ReflectionClass[] $classReflections            
     * @return \SK\ITCBundle\Command\Tests\AbstractGenerator
     */
    public function setClassReflections($classReflections)
    {
        $this->classReflections = $classReflections;
        return $this;
    }

    /**
     * Sets SK ITCBundle Command Code Generator Finder
     *
     * @param Finder $finder
     *            SK ITCBundle Command Code Generator Finder
     * @return \SK\ITCBundle\Command\Code\CodeCommand
     */
    public function setFinder(Finder $finder)
    {
        $this->finder = $finder;
        return $this;
    }

    /**
     * Sets SK ITCBundle Command Code Generator Broker
     *
     * @param Broker $broker
     *            SK ITCBundle Command Code Generator Broker
     * @return \SK\ITCBundle\Command\Code\CodeCommand
     */
    public function setBroker(Broker $broker)
    {
        $this->broker = $broker;
        return $this;
    }
}