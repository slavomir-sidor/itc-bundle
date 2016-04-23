<?php
namespace SK\ITCBundle\Service\Table\Adapter;

use SK\ITCBundle\Service\Table\Table;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Helper\Table as STable;
use Symfony\Component\Console\Helper\TableStyle;
use Symfony\Component\Console\Helper\TableSeparator;
use Symfony\Component\Console\Helper\TableCell;

class TXT implements IAdapter
{

	/**
	 *
	 * @var string
	 */
	const name = 'TXT';

	/**
	 *
	 * {@inheritDoc}
	 *
	 * @see \SK\ITCBundle\Service\Table\Adapter\IAdapter::write()
	 */
	public function write( Table $table, OutputInterface $output )
	{
		$style = new TableStyle();
		$style->setHorizontalBorderChar( '<fg=magenta>-</>' )
			->setVerticalBorderChar( '<fg=magenta>|</>' )
			->setCrossingChar( '<fg=magenta>+</>' );

		$stable = new STable(
			$this->getOutput() );
		$stable->setStyle( 'default' );
		$table->setHeaders( $table->getHeaders() );

		$columns = $table->getColumns();
		$colspan = count( $columns );

		$rows = $this->getRows();

		foreach( $rows as $row )
		{
			$rowModificated = [];

			foreach( $columns as $iCol => $col )
			{
				if( is_int( $iCol ) )
				{
					$iCol = $col;
				}

				if( array_key_exists( $iCol, $row ) )
				{
					$rowModificated[$iCol] = wordwrap( $row[$iCol], $table->maxColWidth, "\n", true );
				}
				else
				{
					$rowModificated[$iCol] = "";
				}
			}

			$table->addRow( $rowModificated );
			$table->addRow( array(
				new TableSeparator(
					array(
						'colspan' => $colspan
					) )
			) );
		}

		$table->addRow( array(
			new TableCell(
				"",
				array(
					'colspan' => $colspan
				) )
		) );

		$table->addRow( array(
			new TableCell(
				sprintf( "Found %s results.", count( $rows ) ),
				array(
					'colspan' => $colspan
				) )
		) );
	}
}