<?php
namespace SK\ITCBundle\Command\Code\Generator\DockBlock;

use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Input\InputInterface;
use TokenReflection\Php\ReflectionClass;

class ClassCommand extends AbstractCommand
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
			->getClasses()
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
				->getClasses()
				->toArray() );

			/* @var $class ReflectionClass */
			foreach( $this->getReflection()->getClasses() as $class )
			{
				print_R($class->g);
			}
		}

		return $this->rows;
	}
}