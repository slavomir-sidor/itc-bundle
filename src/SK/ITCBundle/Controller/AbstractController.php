<?php
namespace SK\ITCBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class AbstractController extends Controller
{

	/**
	 */
	public function __construct()
	{}

	/**
	 *
	 */
	protected function getRequest()
	{
		return $this->container->get( 'request_stack' )->getCurrentRequest();
	}
}