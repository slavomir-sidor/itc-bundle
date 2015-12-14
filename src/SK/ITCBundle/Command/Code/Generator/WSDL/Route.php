<?php

/**
 * SK ITCBundle Generator Route
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\WSDL;

use SK\ITCBundle\Command\Code\Generator\WSDL\AbstractGenerator;

class Route extends AbstractGenerator
{
	
	/**
	 *
	 * @param OptionsResolverInterface $resolver        	
	 */
	protected function configureOptions( OptionsResolverInterface $resolver )
	{
		$resolver->setDefaults( array( 
				'controllerClass' => 'SK\\ITCBundle\\Controller\\AbstractController' 
		) );
	}
}