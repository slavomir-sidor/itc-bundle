<?php
namespace SK\ITCBundle\Service\Table\Adapter;

use SK\ITCBundle\Service\Table\Table;
use Symfony\Component\Console\Output\OutputInterface;

class SpreedSheet implements IAdapter
{

	/**
	 *
	 * @var string
	 */
	const name = 'SpreedSheet';

	/**
	 *
	 * @param string $format
	 */
	public function write( Table $table, OutputInterface $output )
	{
	}
}