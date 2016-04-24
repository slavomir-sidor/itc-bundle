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
use Symfony\Component\Console\Input\InputOption;
use SK\ITCBundle\Service\Table\Adapter\TXT;

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

		$this->addOption( "format", "f", InputOption::VALUE_OPTIONAL, "Output format (" . implode( ", ", Table::getOutputFormat() ) . ")", TXT::name );
		$this->addOption( "outputFileName", "ofn", InputOption::VALUE_REQUIRED, "Output File name." );
		$this->addOption( "maxColWidth", "cw", InputOption::VALUE_OPTIONAL, "Maximum character width per table col" );
	}

	/**
	 * Writes SK ITCBundle Abstract Command Table
	 *
	 * @param int $maxColWidth
	 * @return \SK\ITCBundle\Command\AbstractCommand SK ITCBundle Abstract Command
	 */
	protected function writeTable()
	{
		if( $this->getInput()->hasOption( 'format' ) )
		{
			$format = $this->getInput()->getOption( 'format' );
		}

		$table = $this->getTable();

		ob_start();
		$table->write( $format, $this->getOutput() );
		$content = ob_get_contents();
		ob_clean();

		if( $this->getInput()->hasOption( 'outputFileName' ) && ( $outputFileName = $this->getInput()->getOption( 'outputFileName' ) ) !== null )
		{
			file_put_contents( $outputFileName, $content );
		}

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
		$this->table->setColumns( $this->getColumns() );
		$this->table->setRows( $this->getRows() );
		$this->table->setTitle( $this->getName() );
		$this->table->setDescription( $this->getDescription() );

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