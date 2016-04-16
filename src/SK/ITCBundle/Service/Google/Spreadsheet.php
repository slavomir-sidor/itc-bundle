<?php

namespace SK\ITCBundle\Google;

use SK\ITCBundle\Service\AbstractService;
use Monolog\Logger;

class Spreadsheet extends AbstractService
{
    /**
     *
     * @var string
     */
    protected $token;

    /**
     *
     * @param Logger $logger
     * @param string $token
     */
    public function __construct($logger, $token)
    {
        parent::__construct ( $logger );
        $this->setToken ( $token );
    }

    /**
     *
     * @return string
     */
    public function getToken()
    {
        return $this->token;
    }

    /**
     *
     * @param string $token
     */
    public function setToken($token)
    {
        $this->token = $token;
        return $this;
    }
}