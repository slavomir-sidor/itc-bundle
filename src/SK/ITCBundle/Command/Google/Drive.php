<?php

/**
 * SK ITCBundle Google Translator
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Google;

use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Input\InputArgument;
use SK\ITCBundle\Command\AbstractCommand;
use Google\Spreadsheet\DefaultServiceRequest;
use Google\Spreadsheet\ServiceRequestFactory;
use Symfony\Bridge\Monolog\Logger;

class Drive extends AbstractCommand
{
    /**
     *
     * @param string $name
     * @param string $description
     * @param Logger $logger
     */
    public function __construct($name, $description, Logger $logger)
    {
        parent::__construct ( $name, $description, $logger );
    }

    /**
     * (non-PHPdoc)
     *
     * @see \Symfony\Component\Console\Command\Command::configure()
     */
    protected function configure()
    {
        parent::configure ();
    }

    /**
     * (non-PHPdoc)
     *
     * @see \Symfony\Component\Console\Command\Command::execute()
     */
    public function execute(InputInterface $input, OutputInterface $output)
    {
    }
}