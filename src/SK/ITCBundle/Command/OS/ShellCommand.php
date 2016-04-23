<?php

/**
 * SK ITCBundle Command Mylyn Report Command
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\OS;

use SK\ITCBundle\Service\OS\Command;
use SK\ITCBundle\Command\TableCommand;
use Symfony\Bridge\Monolog\Logger;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Input\InputInterface;

class ShellCommand extends TableCommand
{

    /**
     *
     * @var Command
     */
    protected $command;

    /**
     * Constructs SK ITCBundle Abstract Command
     *
     * @param string $name
     * @param string $description
     * @param Logger $logger
     * @param Command $commad
     */
    public function __construct($name, $description, Logger $logger, Command $command)
    {
        parent::__construct ( $name, $description, $logger );

        $this->setCommand ( $command );
    }

    /**
     * (non-PHPdoc)
     *
     * @see \SK\ITCBundle\Code\Generator\PHPUnit\AbstractGenerator::execute($input, $output)
     */
    public function execute(InputInterface $input, OutputInterface $output)
    {
        parent::execute ( $input, $output );

        $this->writeTable ( 120 );
    }

    /**
     *
     * {@inheritDoc}
     *
     * @see \SK\ITCBundle\Command\TableCommand::getColumns()
     */
    protected function getColumns()
    {
        return array (
            'command' => $this->getCommand ()->getPrefix () . ' ' .
                 implode ( ' ', $this->getCommand ()->getArguments () )
        );
    }

    /**
     *
     * {@inheritDoc}
     *
     * @see \SK\ITCBundle\Command\TableCommand::getRows()
     */
    protected function getRows()
    {
        if (null === $this->rows)
        {
            $this->getCommand ()->run ();
            $process = $this->getCommand ()->getProcess ();

            $rows = [
                [
                    'command' => $process->getOutput ()
                ]
            ]
            ;
            $this->setRows ( $rows );
        }

        return $this->rows;
    }

    /**
     *
     * @return Command
     */
    protected function getCommand()
    {
        return $this->command;
    }

    /**
     *
     * @param Command $command
     */
    protected function setCommand(Command $command)
    {
        $this->command = $command;
        return $this;
    }
}