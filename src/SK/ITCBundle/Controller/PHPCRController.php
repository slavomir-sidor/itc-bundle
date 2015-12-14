<?php

/**
 * SK ITC Bundle PHPCR Controller
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Controller;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Finder\Finder;
use SK\ITCBundle\Response\Model;

class PHPCRController extends FilesystemController
{
	public function indexAction()
	{
		return $this->render( 'SKITCBundle:PHPCR:index.html.twig', $this->getModel() );
	}
	public function toolbarAction()
	{
		return $this->render( 'SKITCBundle:PHPCR:toolbar.html.twig', $this->getModel() );
	}
	public function workspaceAction()
	{
		return $this->render( 'SKITCBundle:PHPCR:workspace.html.twig', $this->getModel() );
	}
	public function createAction()
	{
		return $this->render( 'SKITCBundle:PHPCR:Create/index.html.twig', $this->getModel() );
	}
	public function editAction()
	{
		return $this->render( 'SKITCBundle:PHPCR:Edit/index.html.twig', $this->getModel() );
	}
	public function saveAction()
	{
		return $this->render( 'SKITCBundle:PHPCR:Save/index.html.twig', $this->getModel() );
	}
	public function detailAction()
	{
		$model = $this->getModel();
		return $this->render( 'SKITCBundle:PHPCR:Detail/index.html.twig', $model );
	}
	public function deleteAction()
	{
		return $this->render( 'SKITCBundle:PHPCR:Delete/index.html.twig', $this->getModel() );
	}
	
	/**
	 *
	 * @return multitype:\SplFileInfo \Symfony\Component\Finder\Finder
	 *         \Symfony\Component\HttpFoundation\mixed
	 */
	protected function getModel()
	{
		// $model = new Model();
		$model = parent::getModel();
		$model = $model[ 'model' ];
		$request = $this->getRequest();
		
		return array( 
				'model' => $model 
		);
	}
	
	/**
	 *
	 * @param string $path        	
	 * @return \Symfony\Component\Finder\Finder
	 */
	protected function getFinder( $path )
	{
		$finder = new Finder();
		
		$finder->ignoreDotFiles( TRUE );
		$finder->depth( 0 );
		$finder->exclude( $this->excludeDirs );
		
		if( ! is_dir( $path ) )
		{
			return $finder;
		}
		$finder->in( $path );
		
		return $finder;
	}
}