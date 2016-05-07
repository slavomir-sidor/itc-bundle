<?php
/**
 * SK ITC ORM Bundle Application REST Kernel
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Application;

use Symfony\Component\HttpKernel\Kernel;
use Symfony\Bundle\MonologBundle\MonologBundle;
use Symfony\Bundle\FrameworkBundle\FrameworkBundle;
use Symfony\Component\Config\Loader\LoaderInterface;
use Doctrine\Bundle\DoctrineBundle\DoctrineBundle;
use Symfony\Bundle\SecurityBundle\SecurityBundle;
use Symfony\Bundle\SwiftmailerBundle\SwiftmailerBundle;
use Symfony\Bundle\AsseticBundle\AsseticBundle;
use JMS\SerializerBundle\JMSSerializerBundle;
use Symfony\Bundle\TwigBundle\TwigBundle;
use SK\ITCBundle\SKITCBundle;
use Sensio\Bundle\FrameworkExtraBundle\SensioFrameworkExtraBundle;

class RESTKernel extends Kernel
{

	/**
	 *
	 * {@inheritDoc}
	 *
	 * @see \SK\ITCBundle\Application\ConsoleKernel::registerBundles()
	 */
	public function registerBundles()
	{
		$bundles = array(

			new DoctrineBundle(),
			new MonologBundle(),
			new JMSSerializerBundle(),
			new SwiftmailerBundle(),
			new SecurityBundle(),
			new TwigBundle(),
			new FrameworkBundle(),
			new AsseticBundle(),
			new SKITCBundle(),
			new SensioFrameworkExtraBundle(),
		);

		if( in_array( $this->getEnvironment(), array(
			'dev',
			'test'
		) ) )
		{
			//$bundles[] = new DebugBundle();
			//$bundles[] = new Symfony\Bundle\WebProfilerBundle\WebProfilerBundle();
			//$bundles[] = new Sensio\Bundle\DistributionBundle\SensioDistributionBundle();
			//$bundles[] = new Sensio\Bundle\GeneratorBundle\SensioGeneratorBundle();
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