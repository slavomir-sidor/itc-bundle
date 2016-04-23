<?php
namespace SK\ITCBundle\Service\Table;

use SK\ITCBundle\Service\AbstractService;
use Symfony\Component\Console\Helper\STable;
use Symfony\Component\Console\Helper\TableStyle;
use Symfony\Component\Console\Helper\TableCell;
use Symfony\Component\Console\Helper\TableSeparator;
use Symfony\Bridge\Monolog\Logger;
use Symfony\Component\Console\Output\OutputInterface;

class Table extends AbstractService
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
	 * @var array
	 */
	protected $headers;

	/**
	 *
	 * @var int
	 */
	protected $maxColWidth;

	/**
	 *
	 * @param Logger $logger
	 */
	public function __construct( Logger $logger )
	{
		parent::__construct( $logger );
	}

	/**
	 *
	 * @param string $format
	 */
	public function write( $format = 'TXT', OutputInterface $output )
	{
		$adapter = new $format();
		$adapter->write( $this->getHeaders(), $this->getRows() );
	}

	/**
	 *
	 * @return array
	 */
	public function getColumns()
	{
		return $this->columns;
	}

	/**
	 *
	 * @param array $columns
	 */
	public function setColumns( array $columns )
	{
		$this->columns = $columns;
		return $this;
	}

	/**
	 *
	 * @return array
	 */
	public function getRows()
	{
		return $this->rows;
	}

	/**
	 *
	 * @param array $rows
	 */
	public function setRows( array $rows )
	{
		$this->rows = $rows;
		return $this;
	}

	/**
	 *
	 * @return array
	 */
	public function getHeaders()
	{
		if( null === $this->headers )
		{
			$columns = $this->getColumns();
			$colspan = count( $columns );
			$headers = [];

			$headers[] = array(
				new TableCell(
					sprintf( "%s", $this->getDescription() ),
					array(
						'colspan' => $colspan
					) )
			);

			if( $columns )
			{
				$headers[] = array_values( $columns );
			}

			$this->setHeaders( $headers );
		}
		return $this->headers;
	}

	/**
	 *
	 * @param array $headers
	 */
	public function setHeaders( array $headers )
	{
		$this->headers = $headers;
		return $this;
	}
}