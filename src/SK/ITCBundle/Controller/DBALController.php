<?php

/**
 * SK ITC Bundle DBAL Controller
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Controller;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Finder\Finder;
use Symfony\Component\ClassLoader\ClassMapGenerator;
use Zend\Code\Reflection\FileReflection;
use Zend\Code\Reflection\ClassReflection;
use Symfony\Component\Serializer\Encoder\XmlEncoder;
use Symfony\Component\Serializer\Normalizer\GetSetMethodNormalizer;
use Symfony\Component\Serializer\Serializer;
use Symfony\Component\HttpFoundation\Response;
use Zend\Code\Scanner\AggregateDirectoryScanner;
use SK\ITCBundle\Code\Reflection\BundleReflection;
use Zend\Soap\Wsdl;
use Zend\Soap\AutoDiscover;
use Doctrine\DBAL\Connection;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Configuration;

class DBALController extends FilesystemController
{
	public function indexAction()
	{
		return $this->render( 'SKITCBundle:DBAL:index.html.twig', $this->getModel() );
	}
	public function toolbarAction()
	{
		return $this->render( 'SKITCBundle:DBAL:toolbar.html.twig', $this->getModel() );
	}
	public function workspaceAction()
	{
		return $this->render( 'SKITCBundle:DBAL:workspace.html.twig', $this->getModel() );
	}
	public function connectionAction()
	{
		return $this->render( 'SKITCBundle:DBAL:Connection/index.html.twig', $this->getModel() );
	}
	public function entityManagerAction()
	{
		return $this->render( 'SKITCBundle:DBAL:EntityManager/index.html.twig', $this->getModel() );
	}
	public function entityAction()
	{
		return $this->render( 'SKITCBundle:DBAL:Entity/index.html.twig', $this->getModel() );
	}
	
	/**
	 *
	 * @return multitype:\SplFileInfo \Symfony\Component\Finder\Finder
	 *         \Symfony\Component\HttpFoundation\mixed
	 */
	protected function getModel()
	{
		$model = parent::getModel();
		$doctrine = $this->getDoctrine();
		$model = $model[ 'model' ];
		$model[ 'doctrine' ] = $doctrine;
		$model[ 'connection' ] = $this->getRequest()->get( 'connection', NULL );
		$model[ 'entityManager' ] = $this->getRequest()->get( 'entityManager', NULL );
		$model[ 'entity' ] = $this->getRequest()->get( 'entity', NULL );
		$model[ 'page' ] = $this->getRequest()->get( 'page', NULL );
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
		$finder = parent::getFinder( $path );
		$finder->name( '/\AppKernel.php$/' );
		$finder->files();
		return $finder;
	}
}