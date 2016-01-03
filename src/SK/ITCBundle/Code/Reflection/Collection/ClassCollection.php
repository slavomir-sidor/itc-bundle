<?php
namespace SK\ITCBundle\Code\Reflection\Collection;

use TokenReflection\Php\ReflectionClass;
use SK\ITCBundle\Code\Reflection\Collection;

class ClassCollection extends Collection
{

	/**
	 *
	 * @var ReflectionClass[]
	 */
	protected $elements;

	/**
	 *
	 * @var array
	 */
	protected $columns = array(
		'PHP Object',
		'Final',
		'Abstract',
		'Namespace Name',
		'Parent',
		'Implements Interfaces'
	);

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
		$rows = [];

		/* @var $reflection ReflectionClass */
		foreach( $this->getIterator() as $reflection )
		{
			$row = [];

			$row['object'] = self::getObjectType( $reflection );
			$row['final'] = $reflection->isFinal() ? "Final" : "";
			$row['abstract'] = $reflection->isAbstract() ? "Abstract" : "";
			$row['name'] = $reflection->getName();
			$row['parent'] = implode( "\n", $reflection->getParentClassNameList() );
			$row['interface'] = implode( "\n", $reflection->getInterfaceNames() );

			$rows[] = $row;
		}
		return $rows;
	}
}