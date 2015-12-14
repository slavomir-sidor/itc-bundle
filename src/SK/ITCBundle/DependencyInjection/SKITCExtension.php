<?php

/**
 * SK ITC Bundle Code Bundle Dependency Injection Extention
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\DependencyInjection;

use Symfony\Component\DependencyInjection\ContainerBuilder;
use Symfony\Component\Config\FileLocator;
use Symfony\Component\HttpKernel\DependencyInjection\Extension;
use Symfony\Component\DependencyInjection\Loader;
use Symfony\Bundle\FrameworkBundle\DependencyInjection\Configuration;
use Symfony\Component\DependencyInjection\Loader\XmlFileLoader;

class SKITCExtension extends Extension
{
	
	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\DependencyInjection\Extension\ExtensionInterface::load()
	 */
	public function load( array $configs, ContainerBuilder $container )
	{
		$loader = new XmlFileLoader( $container, new FileLocator( __DIR__ . '/../Resources/config' ) );
		$loader->load( 'parameters.xml' );
		$loader->load( 'services.xml' );
	}
}