<?php

namespace SK\ITCBundle\Service\OS;

use Symfony\Component\Process\ProcessBuilder;
use Symfony\Component\Process\Exception\ProcessFailedException;
use SK\ITCBundle\Service\AbstractService;
use Symfony\Bridge\Monolog\Logger;
use Symfony\Component\Process\Process;

class Command extends AbstractService
{

    /**
     * Prefix
     *
     * @var string
     */
    protected $prefix;

    /**
     *
     * @var string
     */
    protected $arguments;

    /**
     *
     * @var Process
     */
    protected $process;

    /**
     *
     * @var ProcessBuilder
     */
    protected $processBuilder;

    /**
     */
    public function __construct(Logger $logger, $prefix, $arguments)
    {
        parent::__construct ( $logger );

        $this->setPrefix ( $prefix );
        $this->setArguments ( $arguments );
    }

    /**
     *
     * @throws ProcessFailedException
     */
    public function run()
    {
        $result=$this->getProcess ()->run ();
        return $result;
    }

    /**
     */
    public function getPrefix()
    {
        return $this->prefix;
    }

    /**
     *
     * @param unknown $prefix
     */
    public function setPrefix($prefix)
    {
        $this->prefix = $prefix;
        return $this;
    }

    /**
     */
    public function getArguments()
    {
        return $this->arguments;
    }

    /**
     *
     * @param unknown $arguments
     */
    public function setArguments($arguments)
    {
        $this->arguments = $arguments;
        return $this;
    }

    /**
     *
     * @return Process
     */
    public function getProcess()
    {
        if (null === $this->process)
        {
            $this->setProcess ( $this->getProcessBuilder ()->getProcess () );
        }
        return $this->process;
    }

    /**
     *
     * @param Process $process
     */
    public function setProcess(Process $process)
    {
        $this->process = $process;
        return $this;
    }

    /**
     *
     * @return ProcessBuilder
     */
    public function getProcessBuilder()
    {
        if (null === $this->processBuilder)
        {
            $processBuilder = new ProcessBuilder ();
            $processBuilder->setPrefix ( $this->getPrefix () );
            $processBuilder->setArguments ( $this->getArguments () );
            $this->setProcessBuilder ( $processBuilder );
        }

        return $this->processBuilder;
    }

    /**
     *
     * @param ProcessBuilder $processBuilder
     */
    public function setProcessBuilder(ProcessBuilder $processBuilder)
    {
        $this->processBuilder = $processBuilder;
        return $this;
    }
}