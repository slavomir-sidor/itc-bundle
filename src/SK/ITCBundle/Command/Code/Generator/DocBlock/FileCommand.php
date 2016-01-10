<?php
/**
 * SK ITCBundle Command Code Reflection Files
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\DocBlock;

use Zend\Code\Generator\FileGenerator;
use Zend\Code\Generator\DocBlockGenerator;

class FileCommand extends DocBlockCommand
{

	/**
	 *
	 * {@inheritDoc}
	 *
	 * @see \SK\ITCBundle\Command\TableCommand::getColumns()
	 */
	protected function getColumns()
	{
		return $this->getReflection()
			->getFiles()
			->getColumns();
	}

	/**
	 *
	 * {@inheritDoc}
	 *
	 * @see \SK\ITCBundle\Command\TableCommand::getRows()
	 */
	protected function getRows()
	{
		if( null === $this->rows )
		{
			$files = $this->getGenerator()->getFiles();

			/* @var $file FileGenerator */
			foreach( $files as $fileName=> $file )
			{
				$docBlock = $file->getDocBlock();

				if( NULL === $docBlock )
				{
					$docBlock = new DocBlockGenerator();
					$file->setDocBlock( $docBlock );
				}

				$classes = $file->getClasses();
				$shortDescriptions = [];
				foreach( $classes as $class )
				{
					$shortDescriptions[] = sprintf( "%s %s", implode( " ", explode( "\\", $file->getNamespace() ) ), $class->getName() );
				}
				$docBlock->setShortDescription( implode( "\n", $shortDescriptions ) );

				$tags = $docBlock->getTags();

				foreach( $tags as $tag )
				{
					switch( $tag->getName() )
					{
						default:
							break;
					}
				}

				$this->getGenerator()->generate( $file, $fileName );
			}

			$this->setRows( $files->toArray() );
		}

		return $this->rows;
	}
}