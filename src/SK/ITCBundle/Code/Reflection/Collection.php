<?php
namespace SK\ITCBundle\Code\Reflection;

use PhpCollection\Map;

abstract class Collection extends Map
{
	use Helper;

	/**
	 *
	 * @var array
	 */
	protected $columns = array();

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
	 * @return array
	 */
	public function toArray()
	{
		return $this->getIterator()->serialize();
	}
}