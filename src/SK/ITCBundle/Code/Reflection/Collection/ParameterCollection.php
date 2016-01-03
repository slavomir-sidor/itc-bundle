<?php
namespace SK\ITCBundle\Code\Reflection\Collection;

use SK\ITCBundle\Code\Reflection\Collection;
use TokenReflection\Php\ReflectionParameter;

class ParameterCollection extends Collection
{

	/**
	 *
	 * @var ReflectionParameter[]
	 */
	protected $elements;

	/**
	 *
	 * @var array $columns
	 */
	protected $columns = array(
		'Class Name',
		'Operation',
		'Parameter',
		'Type',
		'Default'
	);

	/**
	 *
	 * @return array
	 */
	public function toArray()
	{
		$rows = [];

		/* @var $reflection  ReflectionParameter */
		foreach( $this->getIterator() as $reflection )
		{
			$row = [];

			$row['Class'] = $reflection->getDeclaringClassName();
			$row['Operation'] = $reflection->getDeclaringFunctionName();
			$row['Parameter'] = $reflection->getName();
			// $row[ 'Type' ] = $reflection->getOriginalTypeHint();
			// $row[ 'Default' ] = is_array( $reflection->getDefaultValue() ) ? 'array' : $reflection->getDefaultValue();

			$rows[] = $row;
		}

		return $rows;
	}
}