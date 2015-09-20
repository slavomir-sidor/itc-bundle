<?php
/**
 * SK ITC Bundle Default Controller
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Controller;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Finder\Finder;
use SK\ITCBundle\Response\Model;

class FilesystemController extends Controller
{

	protected $excludeDirs = array(
		'.git',
		'target',
		'var'
	);

	public function indexAction()
	{
		return $this->render('SKITCBundle:Filesystem:index.html.twig', $this->getModel());
	}

	public function toolbarAction()
	{
		return $this->render('SKITCBundle:Filesystem:toolbar.html.twig', $this->getModel());
	}

	public function workspaceAction()
	{
		return $this->render('SKITCBundle:Filesystem:workspace.html.twig', $this->getModel());
	}

	public function createAction()
	{
		return $this->render('SKITCBundle:Filesystem:Create/index.html.twig', $this->getModel());
	}

	public function editAction()
	{
		return $this->render('SKITCBundle:Filesystem:Edit/index.html.twig', $this->getModel());
	}

	public function saveAction()
	{
		return $this->render('SKITCBundle:Filesystem:Save/index.html.twig', $this->getModel());
	}

	public function detailAction()
	{
		$model = $this->getModel();
		return $this->render('SKITCBundle:Filesystem:Detail/index.html.twig', $model);
	}

	public function deleteAction()
	{
		return $this->render('SKITCBundle:Filesystem:Delete/index.html.twig', $this->getModel());
	}

	/**
	 *
	 * @return multitype:\SplFileInfo \Symfony\Component\Finder\Finder
	 *         \Symfony\Component\HttpFoundation\mixed
	 */
	protected function getModel()
	{
		// $model = new Model();
		$model = array();
		$request = $this->getRequest();
		$model['request'] = $request;
		$model['currentRoute'] = $request->get('_route');
		
		foreach (array(
			'cs_CZ',
			'en_US',
			'de_DE'
		) as $locale)
		{}
		
		$path = $request->get('path', '');
		$rootDir = $this->get('kernel')->getRootDir();
		$rootDirInfo = new \SplFileInfo($rootDir);
		
		$filesystemPath = sprintf("%s/%s", $rootDirInfo->getPath(), $path);
		$filesystemInfo = new \SplFileInfo($filesystemPath);
		// $pathInfo->getPathname()
		$model['path'] = $path;
		$model['filesystemPath'] = $filesystemPath;
		$model['filesystemPathInfo'] = $filesystemInfo;
		
		$kernel = $this->get('kernel');
		// $model['environments']=$kernel->
		
		if (is_dir($filesystemPath))
		{
			$model['finder'] = $this->getFinder($filesystemPath);
		}
		else
		{
			$source = file_get_contents($filesystemPath);
			$extention = $filesystemInfo->getExtension();
			$language = $filesystemInfo->getExtension();
			switch ($language)
			{
				case '':
					{
						$language = "txt";
						break;
					}
				case 'js':
					{
						$language = "javascript";
						break;
					}
				case 'yml':
					{
						$language = "yaml";
						break;
					}
				case 'xmi':
				case 'xsd':
				case 'wsdl':
					{
						$language = "xml";
						break;
					}
			}
			$geshi = new \GeSHi($source, $language);
			
			$model['highlight'] = $geshi->parse_code();
			$model['source'] = $source;
		}
		
		return array('model'=>$model);
	}

	/**
	 *
	 * @param string $path        	
	 * @return \Symfony\Component\Finder\Finder
	 */
	protected function getFinder($path)
	{
		$finder = new Finder();
		
		$finder->ignoreDotFiles(TRUE);
		$finder->depth(0);
		$finder->exclude($this->excludeDirs);
		
		if (! is_dir($path))
		{
			return $finder;
		}
		$finder->in($path);
		
		return $finder;
	}
}