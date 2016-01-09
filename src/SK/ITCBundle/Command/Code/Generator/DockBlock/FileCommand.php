<?php
namespace SK\ITCBundle\Command\Code\Generator\DockBlock;

use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Input\InputInterface;
use TokenReflection\ReflectionFile;

class FileCommand extends AbstractCommand
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
			$this->setRows( $this->getReflection()
				->getFiles()
				->toArray() );

			/* @var $file ReflectionFile */
			foreach( $this->getReflection()->getFiles() as $file )
			{

			}
		}

		return $this->rows;
	}
}