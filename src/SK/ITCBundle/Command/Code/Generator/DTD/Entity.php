<?php

/**
 * SK ITCBundle Command Code Generator DTD Entity
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
use SK\ITCBundle\Code\Generator\DTD\Entity as EntityGenerator;

class Entity extends AbstractGenerator
{

	/**
	 * SK ITCBundle Command Code Generator DTD Entity Generator
	 *
	 * @var EntityGenerator
	 */
	protected $generator;

	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\AbstractGenerator\Generator::configure()
	 */
	protected function configure()
	{

		$this->addArgument( 'entityNamespace', InputArgument::OPTIONAL, 'Namespace Name', 'AppBundle\\DTD\\%s\\Entity' );
		$this->addArgument( 'entityParentClass', InputArgument::OPTIONAL, 'Entity Generalized Class', '\\SK\\ITCBundle\\DTD\\Entity' );
		$this->addArgument( 'entityOutput', InputArgument::OPTIONAL, 'Output Folder', 'src/AppBundle/DTD/%s/Entity' );
		
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
		$items = $document->getEntity();
		$directory = sprintf( $input->getArgument( 'entityOutput' ), $document->getFileInfo()
			->getBasename( '.dtd' ) );
		$namespace = sprintf( $input->getArgument( 'entityNamespace' ), $document->getFileInfo()
			->getBasename( '.dtd' ) );
		$parentClass = $input->getArgument( 'entityParentClass' );
		$description = str_replace( "\\", " ", $namespace );
		
		if( ! file_exists( $directory ) )
		{
			mkdir( $directory, 0777, true );
		}
		
		// $progressBar = new ProgressBar($output, $items->count());
		// $progressBar->setFormat('verbose');
		
		foreach( $items as $item )
		{
			$name = sprintf( "%sEntity", Source::camelCase( $item->getName() ) );
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
			// var_dump(get_class($item));
			// $progressBar->advance();
		}
		// $progressBar->finish();
	}

}