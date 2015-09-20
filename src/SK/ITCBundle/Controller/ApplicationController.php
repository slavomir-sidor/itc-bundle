<?php
/**
 * SK ITC Bundle Application Controller
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Controller;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Finder\Finder;
use Symfony\Component\ClassLoader\ClassMapGenerator;
use Symfony\Component\Serializer\Encoder\XmlEncoder;
use Symfony\Component\Serializer\Normalizer\GetSetMethodNormalizer;
use Symfony\Component\Serializer\Serializer;
use Symfony\Component\HttpFoundation\Response;
use SK\ITCBundle\Code\Reflection\BundleReflection;
use AppBundle\DTD\Document\XMLSchema;
use Zend\Code\Reflection\FileReflection;
use Zend\Code\Reflection\ClassReflection;
use Zend\Code\Scanner\AggregateDirectoryScanner;
use Zend\Soap\Wsdl;
use Zend\Soap\AutoDiscover;

class ApplicationController extends FilesystemController
{

	public function indexAction()
	{
		return $this->render('SKITCBundle:Application:index.html.twig', $this->getModel());
	}

	public function toolbarAction()
	{
		return $this->render('SKITCBundle:Application:toolbar.html.twig', $this->getModel());
	}

	public function workspaceAction()
	{
		return $this->render('SKITCBundle:Application:workspace.html.twig', $this->getModel());
	}

	public function containerAction()
	{
		return $this->render('SKITCBundle:Application:Container/index.html.twig', $this->getModel());
	}

	public function createAction()
	{
		return $this->render('SKITCBundle:Application:create.html.twig', $this->getModel());
	}

	public function editAction()
	{
		return $this->render('SKITCBundle:Application:edit.html.twig', $this->getModel());
	}

	public function viewAction()
	{
		return $this->render('SKITCBundle:Application:edit.html.twig', $this->getModel());
	}

	public function filesystemAction()
	{
		return $this->render('SKITCBundle:Application:Filesystem/index.html.twig', $this->getModel());
	}

	public function bundleAction()
	{
		return $this->render('SKITCBundle:Application:Bundle/index.html.twig', $this->getModel());
	}

	public function serviceAction()
	{
		return $this->render('SKITCBundle:Application:service.html.twig', $this->getModel());
	}

	public function modelAction()
	{
		return $this->render('SKITCBundle:Application:namespace.html.twig', $this->getModel());
	}

	public function namespaceAction()
	{
		return $this->render('SKITCBundle:Application:Namespace/index.html.twig', $this->getModel());
	}

	public function configurationAction()
	{
		$model = $this->getModel();
		
		$kernel = $this->get('kernel');
		$configFile = sprintf("%s/config/config.xml", $kernel->getRootDir());
		
		$dom = new XMLSchema($configFile);
		
		$model['model']['dom'] = $dom;
		
		return $this->render('SKITCBundle:Application:Configuration/index.html.twig', $model);
	}

	/**
	 *
	 * @return \Symfony\Component\HttpFoundation\Response
	 */
	public function classAction()
	{
		return $this->render('SKITCBundle:Application:class/index.html.twig', $this->getModel());
	}

	public function classFileAction()
	{
		return $this->render('SKITCBundle:Application:class/file/index.html.twig', $this->getModel());
	}

	public function classSchemaAction()
	{
		$model = $this->getModel();
		
		$request = $this->getRequest();
		$model = $this->getModel();
		$systemCommand = sprintf("%s %s", "phpuml", $model['classFile']);
		
		$output = array();
		$content = "";
		if (exec($systemCommand, $output) || true)
		{
			foreach ($output as $line)
			{
				$content .= $line;
			}
		}
		$response = new Response('Content', Response::HTTP_OK, 
			array(
				
				// 'content-type' => 'application/xml',
				'content-type' => 'text/plain'
			));
		$response->setContent($content);
		$response->prepare($request);
		return $response->send();
	}

	public function deleteAction()
	{
		return $this->render('SKITCBundle:Application:delete.html.twig', $this->getModel());
	}

	/**
	 *
	 * @return multitype:\SplFileInfo \Symfony\Component\Finder\Finder
	 *         \Symfony\Component\HttpFoundation\mixed
	 */
	protected function getModel()
	{
		$model = parent::getModel();
		$model = $model['model'];
		
		$bundle = $this->getRequest()->get('bundle', NULL);
		$namespace = $this->getRequest()->get('namespace', NULL);
		$class = $this->getRequest()->get('class', NULL);
		$kernel = $this->get('kernel');
		$bundles = $kernel->getBundles();
		$classWsdl = null;
		$classWsdlDomDocument = null;
		
		if (NULL !== $bundle && array_key_exists($bundle, $bundles))
		{
			$bundle = new BundleReflection($bundles[$bundle]);
			$namespace = $bundle->getNamespace($namespace);
			
			if (NULL !== $class)
			{
				try
				{
					$class = $namespace->getClassReflection($class);
					$autodiscover = new AutoDiscover();
					$autodiscover->setClass($class->getName())
						->setUri(
						$this->getRequest()
							->getBaseUrl() . $this->getRequest()
							->getRequestUri())
						->setServiceName($class->getName());
					
					$classWsdl = $autodiscover->generate();
					$classWsdlDomDocument = $classWsdl->toDomDocument();
					$classWsdlDomDocument->formatOutput = true;
				}
				catch (\Exception $e)
				{}
			}
		}
		
		$model['bundle'] = $bundle;
		$model['bundles'] = $bundles;
		$model['namespace'] = $namespace;
		$model['class'] = $class;
		$model['classWsdl'] = $classWsdl;
		$model['classWsdlDomDocument'] = $classWsdlDomDocument;
		
		return array(
			'model' => $model
		);
	}

	/**
	 *
	 * @param string $path        	
	 * @return \Symfony\Component\Finder\Finder
	 */
	protected function getFinder($path)
	{
		$finder = parent::getFinder($path);
		$finder->name('/\AppKernel.php$/');
		$finder->files();
		return $finder;
	}
}