<?php

/**
 * SK ITCBundle Abstract Command
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command;

use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Helper\Table;
use Monolog\Logger;

abstract class TableCommand extends AbstractCommand
{
	/**
	 *
	 * @var array
	 */
	protected $tableHeader;

	/**
	 *
	 * @var array
	 */
	protected $tableRows;

	/**
	 *
	 * @return array
	 */
	protected function getTableHeader()
	{
		return $this->tableHeader;
	}

	/**
	 *
	 * @param array $tableHeader
	 */
	protected function setTableHeader( array $tableHeader )
	{
		$this->tableHeader = $tableHeader;
		return $this;
	}

	/**
	 *
	 * @return the array
	 */
	protected function getTableRows()
	{
		return $this->tableRows;
	}

	/**
	 *
	 * @param array $tableRows
	 */
	protected function setTableRows( array $tableRows )
	{
		$this->tableRows = $tableRows;
		return $this;
	}


}