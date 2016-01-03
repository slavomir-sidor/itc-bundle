<?php
namespace SK\ITCBundle\Code\Reflection\Collection;

use SK\ITCBundle\Code\Reflection\Collection;
use TokenReflection\Php\ReflectionProperty;

class AttributesCollection extends Collection
{

	/**
	 *
	 * @var ReflectionProperty[]
	 */
	protected $elements;

	/**
	 *
	 * @var array $columns
	 */
	protected $columns = array(
		'Accessibility',
		'Static',
		'Class',
		'Attribute',
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

		/* @var $reflection ReflectionProperty */
		foreach( $this->getIterator() as $reflection )
		{
			$row = [];

			$row['Accessibility'] = self::getAccessibility( $reflection );
			$row['Static'] = self::getStatic( $reflection );
			$row['Class'] = $reflection->getDeclaringClassName();
			$row['Attribute'] = $reflection->getName();
			$row['Type'] = self::getAttributeType( $reflection );
			$row['Default'] = is_array( $reflection->getDefaultValue() ) ? 'array' : $reflection->getDefaultValue();

			$rows[] = $row;
		}

		return $rows;
	}
}