<?php

namespace SK\ITCBundle\Service\Google;

use SK\ITCBundle\Service\AbstractService;
use Monolog\Logger;
use Google\Spreadsheet\DefaultServiceRequest;
use Google\Spreadsheet\ServiceRequestFactory;
use Google\Spreadsheet\SpreadsheetService;

class Spreadsheet extends AbstractService
{
    /**
     *
     * @var string
     */
    protected $token;

    /**
     *
     * @var SpreadsheetService
     */
    protected $gService;

    /**
     *
     * @param Logger $logger
     * @param string $token
     */
    public function __construct($logger, $token)
    {
        parent::__construct ( $logger );

        /* $serviceRequest = new DefaultServiceRequest($token);
        ServiceRequestFactory::setInstance($serviceRequest);

        $spreadsheetService = new SpreadsheetService();
        $spreadsheetFeed = $spreadsheetService->getSpreadsheetFeed();

        $serviceRequest = new DefaultServiceRequest ( $accessToken );
        ServiceRequestFactory::setInstance ( $serviceRequest );

        $service = $this->getContainer ()->get ( 'sk.itcbundle.google.spreadsheet' );
 */
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