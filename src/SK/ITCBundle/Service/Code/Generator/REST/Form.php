<?php

/**
 * SK ITCBundle Code Abstract Generator
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Code\Generator\REST;

class FormCommand extends CodeGenerator
{

	public function __construct()
	{
		$manager = new DisconnectedMetadataFactory( $this->getContainer()->get( 'doctrine' ) );
	}
}