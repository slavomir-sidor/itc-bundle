<?php

/**
 * SK ITCBundle Code Generator DTD Element
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Code\Generator\DTD;

use Zend\Code\Reflection\ClassReflection;
use Zend\Code\Reflection\FileReflection;
use Zend\Code\Generator\FileGenerator;
use Zend\Code\Generator\ClassGenerator;
use Zend\Code\Generator\DocBlockGenerator;
use Zend\Code\Generator\PropertyGenerator;
use Zend\Code\Generator\DocBlock\Tag;
use SK\ITCBundle\DTD\Source;
use SK\ITCBundle\DTD\Document as DTDDocument;

class Element extends AbstractGenerator
{
	public function generate( DTDDocument $document, $outputDirectory, $namespace, $parentClass )
	{
		$items = $document->getElement();
		$directory = sprintf( $outputDirectory, $document->getFileInfo()->getBasename( '.dtd' ) );
		$namespace = sprintf( $namespace, $document->getFileInfo()->getBasename( '.dtd' ) );
		$description = str_replace( "\\", " ", $namespace );
		
		if( ! file_exists( $directory ) )
		{
			mkdir( $directory, 0777, true );
		}
		
		foreach( $items as $item )
		{
			$name = sprintf( "%sElement", Source::camelCase( $item->getName() ) );
			$filename = sprintf( "%s/%s.php", $directory, $name );
			$classDescription = sprintf( "%s %s", $description, $name );
			$datetime = new \DateTime();
			$properties = array( 
					
					(new PropertyGenerator( "name", $item->getName() ))->setDocBlock( new DocBlockGenerator( sprintf( "%s Name", $classDescription ), "", array( 
							new Tag( "var", "string" ) 
					) ) ),
					
					(new PropertyGenerator( "value", $item->getValue() ))->setDocBlock( new DocBlockGenerator( sprintf( "%s Value", $classDescription ), "", array( 
							new Tag( "var", "string" ) 
					) ) ) 
			);
			$docblock = new DocBlockGenerator( $classDescription, "", array( 
					new Tag( "author", "ITC Generator " . $datetime->format( "d.m.Y h:m:s" ) ),
					new Tag( "copyright", "LGPL" ) 
			) );
			
			$fileGenerator = new FileGenerator();
			$fileGenerator->setClass( new ClassGenerator( $name, $namespace, null, $parentClass, array(), $properties, array(), $docblock ) );
			
			file_put_contents( $filename, $fileGenerator->generate() );
		}
	}
}