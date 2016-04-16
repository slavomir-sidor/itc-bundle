<?php

/**
 * SK ITCBundle Code Generator REST Service
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Code\Generator\REST;

use Doctrine\Bundle\DoctrineBundle\Mapping\DisconnectedMetadataFactory;

class Service extends CodeGenerator
{
	public function __construct()
	{
		$manager = new DisconnectedMetadataFactory( $this->getContainer()->get( 'doctrine' ) );
	}
}