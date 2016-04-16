<?php

/**
 * SK ITCBundle Code Generator DTD Document
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Code\Generator\DTD;

use Zend\Code\Reflection\ClassReflection;
use Zend\Code\Reflection\FileReflection;
use Zend\Code\Generator\FileGenerator;
use Zend\Code\Generator\ClassGenerator;
use Zend\Code\Generator\DocBlockGenerator;
use Zend\Code\Generator\DocBlock\Tag;
use SK\ITCBundle\DTD\Source;
use SK\ITCBundle\DTD\Document as DTDDocument;

class Document extends AbstractGenerator
{

	/**
	 *
	 * @param DTDDocument $document        	
	 * @param string $outputDirectory        	
	 * @param string $namespace        	
	 * @param string $parentClass        	
	 */
	public function generate( 
		DTDDocument $document, 
		$outputDirectory, 
		$namespace, 
		$parentClass )
	{

		if( ! file_exists( $outputDirectory ) )
		{
			mkdir( $outputDirectory, 0777, true );
		}
		$name = ucfirst( $document->getFileInfo()
			->getBasename( '.dtd' ) );
		$filename = sprintf( "%s/%s.php", $outputDirectory, $name );
		$classGenerator = new ClassGenerator( $name, $namespace, null, $parentClass );
		$fileGenerator = new FileGenerator();
		$fileGenerator->setClass( $classGenerator );
		$fileDocblock = new DocBlockGenerator( sprintf( "%s %s", str_replace( "\\", " ", $namespace ), $name ) );
		$fileDocblock->setTag( new Tag( "author", "Generator" ) );
		$fileDocblock->setTag( new Tag( "licence", "LGPL" ) );
		$fileGenerator->setDocBlock( $fileDocblock );
		file_put_contents( $filename, $fileGenerator->generate() );
	
	}

}