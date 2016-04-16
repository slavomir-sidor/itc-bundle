<?php

namespace SK\ITCBundle\Service;

use Monolog\Logger;

abstract class AbstractService {

    /**
     *
     * @var Logger
     */
    protected $logger;
    /**
     * Constructs Action Planner Console Bundle Code Generator
     */
    public function __construct(Logger $logger) {
        $this->setLogger ( $logger );
    }

    /**
     *
     * @return the Logger
     */
    public function getLogger() {
        return $this->logger;
    }

    /**
     *
     * @param Logger $logger
     */
    public function setLogger(Logger $logger) {
        $this->logger = $logger;
        return $this;
    }
}