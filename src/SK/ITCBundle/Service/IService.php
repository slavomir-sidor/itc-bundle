<?php

namespace SK\ITCBundle\Service\Service\IService;

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