<?php

/**
 * SK ITC Bundle Console Controller
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Console\Application;
use Symfony\Component\Console\Output\BufferedOutput;
use Symfony\Component\Console\Input\ArrayInput;
use Symfony\Component\Console\Command\Command;

class ConsoleController extends FilesystemController
{
	
	/**
	 * SK ITC Bundle Console Controller
	 *
	 * @var Application
	 */
	protected $cliApplication;
	public function indexAction()
	{
		return $this->render( 'SKITCBundle:Console:index.html.twig', $this->getModel() );
	}
	public function toolbarAction()
	{
		try
		{
		} catch( \Exception $e )
		{
		}
		
		return $this->render( 'SKITCBundle:Console:toolbar.html.twig', $this->getModel() );
	}
	public function workspaceAction()
	{
		return $this->render( 'SKITCBundle:Console:workspace.html.twig', $this->getModel() );
	}
	public function namespaceAction()
	{
		return $this->render( 'SKITCBundle:Console:namespace.html.twig', $this->getModel() );
	}
	public function runAction()
	{
		$model = $this->getModel();
		
		$requestCommand = $this->getRequest()->get( 'command' );
		$requestArguments = $this->getRequest()->get( 'arguments' );
		$requestOptions = $this->getRequest()->get( 'options' );
		
		$cli = $this->getCliApplication();
		$command = $cli->get( $requestCommand );
		
		$input = new ArrayInput( array( 
				$command->getName(),
				'--no-interaction' 
		) );
		
		$output = new BufferedOutput();
		$cli->run( $input, $output );
		
		$model[ 'output' ] = $output->fetch();
		return $this->render( 'SKITCBundle:Console:run.html.twig', $model );
	}
	public function helpAction()
	{
		$model = $this->getModel();
		
		$requestCommand = $this->getRequest()->get( 'command' );
		
		$cli = $this->getCliApplication();
		$command = $cli->get( $requestCommand );
		
		$model[ 'definition' ] = $command->getDefinition();
		
		$input = new ArrayInput( array( 
				sprintf( "help %s", $requestCommand ) 
		) );
		
		$output = new BufferedOutput();
		// $cli->run($input, $output);
		$model[ 'output' ] = $output->fetch();
		
		return $this->render( 'SKITCBundle:Console:help.html.twig', $model );
	}
	public function commandAction()
	{
		return $this->render( 'SKITCBundle:Console:command.html.twig', $this->getModel() );
	}
	protected function getCliApplication()
	{
		if( NULL === $this->cliApplication )
		{
			
			$kernel = $this->get( 'kernel' );
			$container = $kernel->getContainer();
			
			$cliApplication = new Application( $kernel );
			$cliApplication->setAutoExit( false );
			
			/* @var $bundle Bundle  */
			foreach( $kernel->getBundles() as $bundle )
			{
				$bundle->registerCommands( $cliApplication );
			}
			
			if( $container->hasParameter( 'console.command.ids' ) )
			{
				foreach( $container->getParameter( 'console.command.ids' ) as $id )
				{
					$cliApplication->add( $container->get( $id ) );
				}
			}
			
			$this->cliApplication = $cliApplication;
		}
		return $this->cliApplication;
	}
	protected function getModel()
	{
		$model = parent::getModel();
		$model = $model[ 'model' ];
		$request = $this->getRequest();
		
		$kernel = $this->get( 'kernel' );
		$cli = $this->getCliApplication();
		$commands = $cli->all();
		
		$model[ 'bundles' ] = array_keys( $kernel->getBundles() );
		$model[ 'cli' ] = $this->getCliApplication();
		$model[ 'namespace' ] = $this->getRequest()->get( 'namespace' );
		
		$command = $this->getRequest()->get( 'command' );
		
		if( NULL !== $command )
		{
			$model[ 'command' ] = $cli->get( $command );
		}
		
		return array( 
				'model' => $model 
		);
	}
}