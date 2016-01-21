<?php
/**
 * SK ITC Bundle Application Console Kernel
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Application;

use Symfony\Component\HttpKernel\Kernel;
use Symfony\Component\Config\Loader\LoaderInterface;
use Symfony\Bundle\FrameworkBundle\FrameworkBundle;
use Symfony\Bundle\MonologBundle\MonologBundle;
use JMS\SerializerBundle\JMSSerializerBundle;
use SK\ITCBundle\SKITCBundle;
use Symfony\Bundle\AsseticBundle\AsseticBundle;
use Symfony\Bundle\SecurityBundle\SecurityBundle;

class ConsoleKernel extends Kernel
{
	/**
	 *
	 * {@inheritDoc}
	 *
	 * @see \Symfony\Component\HttpKernel\KernelInterface::registerBundles()
	 */
	public function registerBundles()
	{
		$bundles = array(
			new FrameworkBundle(),
			new JMSSerializerBundle(),
			new MonologBundle(),
			new AsseticBundle(),
			new SecurityBundle(),
			new SKITCBundle()
		);

		if( in_array( $this->getEnvironment(), array(
			'dev',
			'test'
		), true ) )
		{
			// $bundles[] =
		}

		return $bundles;
	}

	/**
	 *
	 * {@inheritDoc}
	 *
	 * @see \Symfony\Component\HttpKernel\Kernel::getRootDir()
	 */
	public function getRootDir()
	{
		return __DIR__ . '/../../../..';
	}

	/**
	 *
	 * {@inheritDoc}
	 *
	 * @see \Symfony\Component\HttpKernel\Kernel::getCacheDir()
	 */
	public function getCacheDir()
	{
		return $this->getRootDir() . '/cache/' . $this->getEnvironment();
	}

	/**
	 *
	 * {@inheritDoc}
	 *
	 * @see \Symfony\Component\HttpKernel\Kernel::getLogDir()
	 */
	public function getLogDir()
	{
		return $this->getRootDir() . '/logs';
	}

	/**
	 *
	 * @param LoaderInterface $loader
	 */
	public function registerContainerConfiguration( LoaderInterface $loader )
	{
		$environment = $this->getEnvironment();
		$config = dirname( __DIR__ ) . sprintf( '/Resources/config/%s/config.xml', $environment );

		if( ! file_exists( $config ) )
		{
			$config = dirname( __DIR__ ) . sprintf( '/Resources/config/config.xml' );
		}

		if( file_exists( $config ) )
		{
			$loader->load( $config );
		}
	}
}