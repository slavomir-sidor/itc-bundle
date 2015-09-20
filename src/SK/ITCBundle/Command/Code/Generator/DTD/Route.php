<?php
/**
 * SK ITCBundle Command Code Generator DTD Route
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\DTD;

use Monolog\Logger;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Formatter\OutputFormatter;
use Symfony\Component\Console\Helper\ProgressBar;
use Zend\Code\Reflection\ClassReflection;
use Zend\Code\Reflection\FileReflection;
use Zend\Code\Generator\FileGenerator;
use Zend\Code\Generator\ClassGenerator;
use Zend\Code\Generator\DocBlockGenerator;
use Zend\Code\Generator\DocBlock\Tag;
use SK\ITCBundle\DTD\Source;
use SK\ITCBundle\Code\Generator\DTD\Route as RouteGenerator;

class Route extends AbstractGenerator
{

	/**
	 * * SK ITCBundle Command Code Generator DTD Security generator
	 *
	 * @var RouteGenerator
	 */
	protected $generator;

	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\AbstractGenerator\Generator::configure()
	 */
	protected function configure()
	{
		$this->addArgument('namespace', InputArgument::OPTIONAL, 'Namespace Name', 'AppBundle\\DTD\\Document');
		$this->addArgument('parentClass', InputArgument::OPTIONAL, 'Entity Generalized Class', 
			'\\SK\\ITCBundle\\DTD\\Document');
		$this->addArgument('output', InputArgument::OPTIONAL, 'Output Folder', 'src/AppBundle/DTD/Document');
		parent::configure();
	}

	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::execute()
	 */
	public function execute(InputInterface $input, OutputInterface $output)
	{}
}