<?php

/**
 * SK ITCBundle Code Abstract Generator
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Service\Code\Generator;

use SK\ITCBundle\Service\Code\Reflection;
use Symfony\Bridge\Monolog\Logger;

class ServiceCommand extends CodeGenerator
{
    /**
     *
     * @var Reflection
     */
    protected $reflection;

    /**
     *
     * @param Logger $logger
     * @param Reflection $reflection
     */
    public function __construct(Logger $logger, Reflection $reflection)
    {
        parent::__construct ( $logger );

        $this->setReflection ( $reflection );
    }

    /**
     *
     * @return the Reflection
     */
    public function getReflection()
    {
        return $this->reflection;
    }

    /**
     *
     * @param Reflection $reflection
     */
    public function setReflection(Reflection $reflection)
    {
        $this->reflection = $reflection;
        return $this;
    }
}