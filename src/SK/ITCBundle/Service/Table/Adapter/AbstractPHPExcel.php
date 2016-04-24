<?php
namespace SK\ITCBundle\Service\Table\Adapter;

use SK\ITCBundle\Service\Table\Table;
use Symfony\Component\Console\Output\OutputInterface;
use PHPExcel\Spreadsheet;
use PHPExcel\IOFactory;
use Symfony\Component\Console\Helper\TableCell;

class AbstractPHPExcel implements IAdapter
{

	/**
	 *
	 * @var Spreadsheet
	 */
	protected $spreadsheet;

	/**
	 *
	 * @var string
	 */
	protected $creator;

	/**
	 *
	 * @var string
	 */
	protected $lastModifiedBy;

	/**
	 *
	 * {@inheritDoc}
	 *
	 * @see \SK\ITCBundle\Service\Table\Adapter\IAdapter::write()
	 */
	public function write( Table $table, OutputInterface $output )
	{
		$this->getSpreadsheet()
			->getProperties()
			->setTitle( $table->getTitle() )
			->setDescription( $table->getDescription() );

		$this->writeHeaders( $table->getHeaders() );
		$this->writeRows( $table->getRows() );

		$writer = IOFactory::createWriter( $this->getSpreadsheet(), 'OpenDocument' );
		$writer->save( 'php://output' );
	}

	protected function writeHeaders( $headers )
	{
		$this->getSpreadsheet()->setActiveSheetIndex( 0 );

		foreach( $headers as $iRow => $columns )
		{
			/* @var $column TableCell */
			foreach( $columns as $iCol => $column )
			{
				$this->getSpreadsheet()
					->getActiveSheet()
					->setCellValueByColumnAndRow( $iCol, $iRow, $column->__toString() );
			}
		}
	}

	protected function writeRows( $rows )
	{
		$iRow = 0;

		foreach( $rows as $columns )
		{
			$iCol = 0;

			foreach( $columns as $column )
			{
				$this->getSpreadsheet()
					->getActiveSheet()
					->setCellValueByColumnAndRow( $iCol, $iRow, $column );

				++ $iCol;
			}

			++ $iRow;
		}
	}

	/**
	 *
	 * @return the Spreadsheet
	 */
	public function getSpreadsheet()
	{
		if( null === $this->spreadsheet )
		{
			$spreedsheeet = new Spreadsheet();
			$this->setSpreadsheet( $spreedsheeet );
		}

		return $this->spreadsheet;
	}

	/**
	 *
	 * @param Spreadsheet $spreadsheet
	 */
	public function setSpreadsheet( Spreadsheet $spreadsheet )
	{
		$this->spreadsheet = $spreadsheet;
		return $this;
	}

	/**
	 *
	 * @return string
	 */
	public function getCreator()
	{
		return $this->creator;
	}

	/**
	 *
	 * @param string $creator
	 */
	public function setCreator( $creator )
	{
		$this->creator = $creator;
		return $this;
	}

	/**
	 *
	 * @return string
	 */
	public function getLastModifiedBy()
	{
		return $this->lastModifiedBy;
	}

	/**
	 *
	 * @param string $lastModifiedBy
	 */
	public function setLastModifiedBy( $lastModifiedBy )
	{
		$this->lastModifiedBy = $lastModifiedBy;
		return $this;
	}
}