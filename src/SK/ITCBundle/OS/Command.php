<?php

namespace SK\ITCBundle\OS;

use Symfony\Component\Process\ProcessBuilder;
use Symfony\Component\Process\Exception\ProcessFailedException;
use SK\ITCBundle\Service\AbstractService;

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
     */
    public function __construct( $prefix, $arguments )
    {
        $this->setPrefix($prefix);
        $this->setArguments($arguments);
    }

    /**
     *
     * @throws ProcessFailedException
     */
    public function run()
    {
        $builder = new ProcessBuilder ();
        $builder->setPrefix ( $this->getPrefix () );
        return $builder->setArguments ( $this->getArguments () )->getProcess ()->getCommandLine ();
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
}