<?php

/**
 * SK ITCBundle Abstract Command
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command;

use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Bridge\Monolog\Logger;

abstract class AbstractCommand extends ContainerAwareCommand
{

    /**
     * SK ITCBundle Abstract Command Input
     *
     * @var InputInterface
     */
    protected $input;

    /**
     * SK ITCBundle Abstract Command Output
     *
     * @var OutputInterface
     */
    protected $output;

    /**
     * SK ITCBundle Abstract Command Logger
     *
     * @var Logger
     */
    protected $logger;

    /**
     * Constructs SK ITCBundle Abstract Command
     *
     * @param string $name
     *            SK ITCBundle Abstract Command Name
     * @param string $description
     *            SK ITCBundle Abstract Command Description
     * @param Logger $logger
     *            SK ITCBundle Abstract Command Logger
     */
    public function __construct($name, $description, Logger $logger)
    {
        parent::__construct ( $name );
        $this->setDescription ( $description );
        $this->setLogger ( $logger );
    }

    /**
     * (non-PHPdoc)
     *
     * @see \Symfony\Component\Console\Command\Command::execute()
     */
    public function execute(InputInterface $input, OutputInterface $output)
    {
        $this->setInput ( $input );
        $this->setOutput ( $output );
    }

    /**
     * (non-PHPdoc)
     *
     * @see \Symfony\Component\Console\Command\Command::configure()
     */
    protected function configure()
    {
        parent::configure ();

        $this->addOption ( "format", "f", InputOption::VALUE_OPTIONAL, "Output format (txt,xml,json)", 'txt' );
    }

    /**
     * Gets SK ITCBundle Abstract Command Input
     *
     * @return InputInterface
     */
    public function getInput()
    {
        return $this->input;
    }

    /**
     * Sets SK ITCBundle Abstract Command Input
     *
     * @param InputInterface $input
     */
    public function setInput(InputInterface $input)
    {
        $this->input = $input;
        return $this;
    }

    /**
     * Gets SK ITCBundle Abstract Command Output
     *
     * @return OutputInterface
     */
    public function getOutput()
    {
        return $this->output;
    }

    /**
     * Sets SK ITCBundle Abstract Command Output
     *
     * @param OutputInterface $output
     */
    public function setOutput(OutputInterface $output)
    {
        $this->output = $output;
        return $this;
    }

    /**
     * Writes SK ITCBundle Abstract Command Line
     *
     * @param string $message
     *            SK ITCBundle Abstract Command Info Line
     * @return \SK\ITCBundle\Command\AbstractCommand SK ITCBundle Abstract Command
     */
    public function writeLine($message = "\n", $verbosity = OutputInterface::VERBOSITY_NORMAL)
    {
        $this->getOutput ()->writeln ( $message, $verbosity );
        return $this;
    }

    /**
     * Writes SK ITCBundle Abstract Command Info
     *
     * @param string $message
     *            SK ITCBundle Abstract Command Info Message
     * @return \SK\ITCBundle\Command\AbstractCommand SK ITCBundle Abstract Command
     */
    public function writeInfo($message, $verbosity = OutputInterface::VERBOSITY_VERBOSE)
    {
        $output = $this->getOutput ();
        $output->writeln ( sprintf ( '<fg=white>%s</fg=white>', $message ), $verbosity );
        return $this;
    }

    /**
     * Writes SK ITCBundle Abstract Command Header
     *
     * @param string $message
     *            SK ITCBundle Abstract Command Header Message
     * @return \SK\ITCBundle\Command\AbstractCommand SK ITCBundle Abstract Command
     */
    public function writeHeader($message)
    {
        $output = $this->getOutput ();
        $output->writeln ( ' <fg=white;bg=magenta>' . $message .
             "</fg=white;bg=magenta>" );
        return $this;
    }

    /**
     * Writes SK ITCBundle Abstract Command Notice
     *
     * @param string $message
     *            SK ITCBundle Abstract Command Notice Message
     * @return \SK\ITCBundle\Command\AbstractCommand SK ITCBundle Abstract Command
     */
    public function writeNotice($message, $verbosity = OutputInterface::VERBOSITY_NORMAL)
    {
        $this->getOutput ()->writeln ( "<fg=blue>{$message}</fg=blue>", $verbosity );
        return $this;
    }

    /**
     * Writes SK ITCBundle Abstract Command Debug
     *
     * @param string $message
     *            SK ITCBundle Abstract Command Debug Message
     * @return \SK\ITCBundle\Command\AbstractCommand SK ITCBundle Abstract Command
     */
    public function writeDebug($message)
    {
        $input = $this->getInput ();
        $output = $this->getOutput ();

        if (self::OPTION_VERBOSE_OUTPUT_YES == $input->getOption ( "verbose" ))
        {
            $output->writeln ( ' <fg=blue;bg=white>DEBUG:</fg=blue;bg=white> ' .
                 $message );
        }
        return $this;
    }

    /**
     * Gets SK ITCBundle Abstract Command Logger
     *
     * @return Logger SK ITCBundle Abstract Command Logger
     */
    public function getLogger()
    {
        return $this->logger;
    }

    /**
     * Sets SK ITCBundle Abstract Command Logger
     *
     * @param Logger $logger
     *            SK ITCBundle Abstract Command Logger
     * @return \SK\ITCBundle\Command\AbstractCommand SK ITCBundle Abstract Command
     */
    public function setLogger(Logger $logger)
    {
        $this->logger = $logger;
    }
}