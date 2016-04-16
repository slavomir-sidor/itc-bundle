<?php
namespace SK\ITCBundle\Service\Code\Generator\Collection;

use TokenReflection\Php\ReflectionMethod;
use SK\ITCBundle\Service\Code\Reflection\Collection\OperationCollection as ReflectionOperationCollection;

class OperationCollection extends ReflectionOperationCollection
{
	/**
	 *
	 * @var ReflectionMethod[]
	 */
	protected $elements;

	/**
	 *
	 * @var array
	 */
	protected $columns = array(
		'Class',
		'Accessibility',
		'Abstract',
		'Static',
		'Operation',
		'Parameters',
		'Returns'
	);

	/**
	 *
	 * @return array
	 */
	public function toArray()
	{
		$rows = [];

		/* @var $reflection ReflectionMethod */
		foreach( $this->getIterator() as $reflection )
		{
			$row = [];

			$row['Class'] = $reflection->getDeclaringClassName();
			$row['Accessibility'] = self::getAccessibility( $reflection );
			$row['Abstract'] = self::getAbstract( $reflection );
			$row['Static'] = self::getStatic( $reflection );
			$row['Operation'] = $reflection->getName();
			$row['Parameters'] = self::getOperationParameters($reflection);
			$row['Returns'] = self::getOperationReturns($reflection);

			$rows[] = $row;
		}
		return $rows;
	}
}