<?php

/**
 * SK ITC Bundle Maven Controller
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class MavenController extends Controller
{

	public function indexAction()
	{

		return $this->render( 'SKITCBundle:Maven:index.html.twig', array( 
			'path' => getcwd() 
		) );
	
	}

	public function toolbarAction()
	{

		return $this->render( 'SKITCBundle:Maven:toolbar.html.twig', array( 
			'path' => getcwd() 
		) );
	
	}

	public function workspaceAction()
	{

		return $this->render( 'SKITCBundle:Maven:workspace.html.twig', array( 
			'path' => getcwd() 
		) );
	
	}

	public function commandAction()
	{

		return $this->render( 'SKITCBundle:Maven:command.html.twig', array( 
			'path' => getcwd() 
		) );
	
	}

	public function helpAction()
	{

		return $this->render( 'SKITCBundle:Maven:command.html.twig', array( 
			'path' => getcwd() 
		) );
	
	}

}