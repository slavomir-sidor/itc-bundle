<?php
namespace SK\ITCBundle\Service\Table;

use SK\ITCBundle\Service\AbstractService;
use Symfony\Bridge\Monolog\Logger;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Helper\TableCell;
use SK\ITCBundle\Service\Table\Adapter\TXT;
use SK\ITCBundle\Service\Table\Adapter\SpreedSheet;
use SK\ITCBundle\Service\Table\Adapter\Excel;

class Table extends AbstractService
{

	/**
	 *
	 * @var string
	 */
	protected $description;

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
	public function __construct( Logger $logger, $maxColWidth )
	{
		parent::__construct( $logger );

		$this->setMaxColWidth( $maxColWidth );
	}

	/**
	 *
	 * @param string $format
	 */
	public function write( $format = TXT::name, OutputInterface $output )
	{
		$name = 'SK\\ITCBundle\\Service\\Table\\Adapter\\' . $format;
		$adapter = new $name();
		$adapter->write( $this, $output );
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
				new TableCell( sprintf( "%s", $this->getDescription() ), array(
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

	/**
	 *
	 * @return string
	 */
	public function getDescription()
	{
		return $this->description;
	}

	/**
	 *
	 * @param string $description
	 */
	public function setDescription( $description )
	{
		$this->description = $description;
		return $this;
	}

	/**
	 *
	 * @return int
	 */
	public function getMaxColWidth()
	{
		return $this->maxColWidth;
	}

	/**
	 *
	 * @param int $maxColWidth
	 */
	public function setMaxColWidth( $maxColWidth )
	{
		$this->maxColWidth = ( int ) $maxColWidth;
		return $this;
	}
}