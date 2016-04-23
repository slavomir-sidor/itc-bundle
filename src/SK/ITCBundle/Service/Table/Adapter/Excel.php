<?php
namespace SK\ITCBundle\Service\Table\Adapter;

use SK\ITCBundle\Service\Table\Table;
use Symfony\Component\Console\Output\OutputInterface;

class Excel implements IAdapter
{

	/**
	 *
	 * @var string
	 */
	const name = 'Excel';

	/**
	 *
	 * {@inheritDoc}
	 *
	 * @see \SK\ITCBundle\Service\Table\Adapter\IAdapter::write()
	 */
	public function write( Table $table, OutputInterface $output )
	{

	}
}