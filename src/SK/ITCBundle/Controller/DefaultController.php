<?php

/**
 * SK ITC Bundle Default Controller
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Controller;

class DefaultController extends FilesystemController
{

	public function indexAction()
	{

		return $this->render( 'SKITCBundle:Default:index.html.twig', $this->getModel() );
	
	}

	public function toolbarAction( 
		$path = NULL )
	{

		return $this->render( 'SKITCBundle:Default:toolbar.html.twig', $this->getModel() );
	
	}

	public function workspaceAction( 
		$path = NULL )
	{

		return $this->render( 'SKITCBundle:Default:workspace.html.twig', $this->getModel() );
	
	}

	public function eastPaneAction( 
		$path = NULL )
	{

		return $this->render( 'SKITCBundle:Default:eastPane.html.twig', $this->getModel() );
	
	}

}