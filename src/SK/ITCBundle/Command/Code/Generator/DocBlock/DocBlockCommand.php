<?php
/**
 * SK ITCBundle Command Code Generator DocBlock DocBlockCommand
 */


namespace SK\ITCBundle\Command\Code\Generator\DocBlock;


use SK\ITCBundle\Command\Code\Generator\GeneratorCommand;
use Symfony\Component\Console\Input\InputOption;

abstract class DocBlockCommand extends SK\ITCBundle\Command\Code\Generator\GeneratorCommand
{

    /**
     * (non-PHPdoc)
     *
     * @see \Symfony\Component\Console\Command\Command::configure()
     */
    protected function configure()
    {
        $this->addOption( "licenceUrl", "lu", InputOption::VALUE_OPTIONAL, "Document block licence url.",
        	'http://www.gnu.org/licenses/lgpl-3.0.html' );
        $this->addOption( "licenceName", "ln", InputOption::VALUE_OPTIONAL, "Document block licence name.", 'GNU LESSER GENERAL PUBLIC LICENSE' );
        $this->addOption( "shortDescription", "sd", InputOption::VALUE_OPTIONAL, "Document block short form." );
        $this->addOption( "longDescription", "ld", InputOption::VALUE_OPTIONAL, "Document block long form." );

        parent::configure();
    }


}

