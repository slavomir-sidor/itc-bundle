<?php

/**
 * SK ITCBundle Command Code Generator DTD Element
 *
 * @licence GNU GPL
 * 
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
use Zend\Code\Generator\PropertyGenerator;
use Zend\Code\Generator\DocBlock\Tag;
use SK\ITCBundle\DTD\Source;
use SK\ITCBundle\Code\Generator\DTD\Element as ElementGenerator;

class Element extends AbstractGenerator
{

	/**
	 * SK ITCBundle Command Code Generator DTD Element Generator
	 *
	 * @var ElementGenerator
	 */
	protected $generator;

	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\AbstractGenerator\Generator::configure()
	 */
	protected function configure()
	{

		$this->addArgument( 'elementNamespace', InputArgument::OPTIONAL, 'Namespace Name', 'AppBundle\\DTD\\%s\\Element' );
		$this->addArgument( 'elementParentClass', InputArgument::OPTIONAL, 'Element Parent Class', '\\SK\\ITCBundle\\DTD\\Element' );
		$this->addArgument( 'elementOutput', InputArgument::OPTIONAL, 'Output Folder', 'src/AppBundle/DTD/%s/Element' );
		parent::configure();
	
	}

	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::execute()
	 */
	public function execute( 
		InputInterface $input, 
		OutputInterface $output )
	{

		$document = $this->getDocument( $input->getArgument( 'document' ) );
		$items = $document->getElement();
		$directory = sprintf( $input->getArgument( 'elementOutput' ), $document->getFileInfo()
			->getBasename( '.dtd' ) );
		$namespace = sprintf( $input->getArgument( 'elementNamespace' ), $document->getFileInfo()
			->getBasename( '.dtd' ) );
		$parentClass = $input->getArgument( 'elementParentClass' );
		$description = str_replace( "\\", " ", $namespace );
		
		if( ! file_exists( $directory ) )
		{
			mkdir( $directory, 0777, true );
		}
		
		$progressBar = new ProgressBar( $output, $items->count() );
		$progressBar->setFormat( 'verbose' );
		
		foreach( $items as $item )
		{
			$name = sprintf( "%sElement", Source::camelCase( $item->getName() ) );
			$filename = sprintf( "%s/%s.php", $directory, $name );
			$classDescription = sprintf( "%s %s", $description, $name );
			$datetime = new \DateTime();
			$properties = array( 
				
				(new PropertyGenerator( "name", $item->getName() ))->setDocBlock( 
					new DocBlockGenerator( sprintf( "%s Name", $classDescription ), "", array( 
						new Tag( "var", "string" ) 
					) ) ),
				
				(new PropertyGenerator( "value", $item->getValue() ))->setDocBlock( 
					new DocBlockGenerator( sprintf( "%s Value", $classDescription ), "", array( 
						new Tag( "var", "string" ) 
					) ) ) 
			);
			$docblock = new DocBlockGenerator( 
				$classDescription, 
				"", 
				array( 
					new Tag( "author", "ITC Generator " . $datetime->format( "d.m.Y h:m:s" ) ),
					new Tag( "copyright", "LGPL" ) 
				) );
			
			$fileGenerator = new FileGenerator();
			$fileGenerator->setClass( new ClassGenerator( $name, $namespace, null, $parentClass, array(), $properties, array(), $docblock ) );
			
			file_put_contents( $filename, $fileGenerator->generate() );
			
			$progressBar->advance();
		}
		$progressBar->finish();
	
	}

}