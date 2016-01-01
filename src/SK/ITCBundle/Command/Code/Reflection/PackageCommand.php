<?php

/**
 * SK ITCBundle Command Code Reflection Namespaces
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Reflection;

use TokenReflection\ReflectionNamespace;

class PackageCommand extends ReflectionCommand
{

	protected $columns = array(
		'Namespace Name',
		'Objects Count'
	);

	/**
	 *
	 * @return array
	 */
	protected function getRows()
	{
		if( NULL === $this->rows )
		{
			$rows = [];

			/* @var $package ReflectionNamespace */
			foreach( $this->getReflection()
				->getPackages() as $package )
			{
				$row=[];

				$row['name'] = $package->getName();
				$row['count'] = $package->getName();

				$rows[]=$row;
			}

			$this->setRows( $rows );
		}

		return $this->rows;
	}
}