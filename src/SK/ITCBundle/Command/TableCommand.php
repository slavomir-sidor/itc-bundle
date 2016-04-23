<?php

/**
 * SK ITCBundle Table Abstract Command
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command;

use Symfony\Component\Console\Command\Command;
use Symfony\Bridge\Monolog\Logger;
use SK\ITCBundle\Service\Table\Table;

abstract class TableCommand extends AbstractCommand
{

	/**
	 *
	 * @var array
	 */
	protected $columns;

	/**
	 *
	 * @var array
	 */
	protected $rows;

	/**
	 *
	 * @var Table
	 */
	protected $table;

	/**
	 *
	 * @param string $name
	 * @param string $description
	 * @param Logger $logger
	 * @param Table $table
	 */
	public function __construct( $name, $description, Logger $logger, Table $table )
	{
		parent::__construct( $name, $description, $logger );

		$this->setTable( $table );
	}

	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::configure()
	 */
	protected function configure()
	{
		parent::configure();
	}

	/**
	 * Writes SK ITCBundle Abstract Command Table
	 *
	 * @param int $maxColWidth
	 * @return \SK\ITCBundle\Command\AbstractCommand SK ITCBundle Abstract Command
	 */
	protected function writeTable()
	{
		$format = $this->getInput()->getOption( 'output' );
		$this->getTable()->write( $format, $this->getOutput() );

		return $this;
	}

	/**
	 *
	 * @return array
	 */
	protected function getRows()
	{
		if( null === $this->rows )
		{
			$this->rows = [];
		}
		return $this->rows;
	}

	/**
	 *
	 * @param array $rows
	 */
	protected function setRows( array $rows )
	{
		$this->rows = $rows;
		return $this;
	}

	/**
	 */
	protected function getTable()
	{
		return $this->table;
	}

	/**
	 *
	 * @param Table $table
	 */
	protected function setTable( Table $table )
	{
		$this->table = $table;
		return $this;
	}

	/**
	 *
	 * @return array
	 */
	protected function getColumns()
	{
		if( null === $this->columns )
		{
			$columns = [];
			$this->setColumns( $columns );
		}
		return $this->columns;
	}

	/**
	 *
	 * @param array $columns
	 */
	protected function setColumns( array $columns )
	{
		$this->columns = $columns;
		return $this;
	}
}