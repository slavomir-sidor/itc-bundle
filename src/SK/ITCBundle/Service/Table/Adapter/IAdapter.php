<?php
namespace SK\ITCBundle\Service\Table\Adapter;

use Symfony\Component\Console\Output\OutputInterface;
use SK\ITCBundle\Service\Table\Table;

interface IAdapter
{

	/**
	 * Write Table
	 *
	 * @param Table $table
	 * @param OutputInterface $output
	 */
	public function write( Table $table, OutputInterface $output );
}