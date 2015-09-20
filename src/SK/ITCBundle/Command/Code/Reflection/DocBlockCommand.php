<?php
namespace SK\ITCBundle\Command\Code\Reflection;

use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

/**
 *
 * @author jahman
 *        
 */
class DocBlockCommand extends ReflectionCommand
{

    /**
     * Constructs SK ITCBundle Command Namespace Abstract Reflection
     *
     * @param string $name
     *            SK ITCBundle Command Code Abstract Reflection Name
     * @param string $description
     *            SK ITCBundle Command Code Abstract Reflection Description
     */
    public function __construct($name = "src:doc", $description = "Source Classes Documentation Blocks")
    {
        parent::__construct($name, $description);
    }

    /**
     * (non-PHPdoc)
     *
     * @see \SK\ITCBundle\Code\Generator\PHPUnit\AbstractGenerator::execute($input, $output)
     */
    public function execute(InputInterface $input, OutputInterface $output)
    {
        parent::execute($input, $output);
        $this->executeDocBlockReflection();
    }
}