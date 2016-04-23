<?php

namespace SK\ITCBundle\Service\IService;

use Symfony\Bridge\Monolog\Logger;

interface IService
{
    /**
     *
     * @return the Logger
     */
    public function getLogger();

    /**
     *
     * @param Logger $logger
     */
    public function setLogger(Logger $logger);
}