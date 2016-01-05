<?php
/**
 * SK ITCBundle Table Abstract Command
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command;

use Symfony\Component\Console\Helper\Table;
use Symfony\Component\Console\Helper\TableStyle;
use Symfony\Component\Console\Helper\TableCell;
use Symfony\Component\Console\Helper\TableSeparator;

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
	protected $headers;

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
	 * Writes SK ITCBundle Abstract Command Table
	 *
	 * @param int $maxColWidth
	 * @return \SK\ITCBundle\Command\AbstractCommand SK ITCBundle Abstract Command
	 */
	protected function writeTable( $maxColWidth = 40 )
	{
		$headers = $this->getHeaders();
		$colspan = count( $this->getColumns() );
		$table = $this->getTable();
		$table->setHeaders( $this->getHeaders( $headers ) );

		$rows = $this->getRows();

		foreach( $rows as $iRow => $row )
		{
			foreach( $row as $iCol => $col )
			{
				$rows[ $iRow ][ $iCol ] = wordwrap( $col, $maxColWidth, "\n", true );
			}

			$table->addRow( $row );
			$table->addRow( array(
				new TableSeparator( array(
					'colspan' => $colspan
				) )
			) );
		}

		$table->addRow( array(
			new TableCell( "", array(
				'colspan' => $colspan
			) )
		) );

		$table->addRow(
			array(
				new TableCell( sprintf( "Found %s results.", count( $rows ) ), array(
					'colspan' => $colspan
				) )
			) );
		$table->render();

		return $this;
	}

	/**
	 *
	 * @return array
	 */
	protected function getHeaders()
	{
		if( null === $this->headers )
		{
			$columns = $this->getColumns();
			$colspan = count( $columns );
			$headers = [];
			$headers[] = array(
				new TableCell( sprintf( "%s", $this->getDescription() ), array(
					'colspan' => $colspan
				) )
			);
			if($columns){
				$headers[] = $columns;
			}
			$this->setHeaders( $headers );
		}
		return $this->headers;
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
	 * @param array $headers
	 */
	protected function setHeaders( array $headers )
	{
		$this->headers = $headers;
		return $this;
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
		if( null === $this->table )
		{
			$style = new TableStyle();
			$style->setHorizontalBorderChar( '<fg=magenta>-</>' )
				->setVerticalBorderChar( '<fg=magenta>|</>' )
				->setCrossingChar( '<fg=magenta>+</>' );

			$table = new Table( $this->getOutput() );
			$table->setStyle( 'default' );
			$this->setTable( $table );
		}
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