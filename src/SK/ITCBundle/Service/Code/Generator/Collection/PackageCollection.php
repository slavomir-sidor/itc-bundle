<?php
namespace SK\ITCBundle\Service\Code\Generator\Collection;

use TokenReflection\ReflectionNamespace;
use SK\ITCBundle\Service\Code\Reflection\Collection\PackageCollection as ReflectionPackageCollection;

class PackageCollection extends ReflectionPackageCollection
{

	/**
	 *
	 * @var ReflectionNamespace[]
	 */
	protected $elements;

	/**
	 *
	 * @var array $columns
	 */
	protected $columns = array(
		'Namespace'
	);

	/**
	 *
	 * @return array
	 */
	public function toArray()
	{
		$rows = [];

		/* @var $package ReflectionNamespace */
		foreach( $this->getIterator() as $package )
		{
			$row = [];
			$row['Namespace'] = $package->getName();
			$rows[] = $row;
		}

		return $rows;
	}
}