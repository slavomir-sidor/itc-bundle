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
		'Namespace'
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

				$row['Namespace'] = $package->getName();

				$rows[]=$row;
			}

			$this->setRows( $rows );
		}

		return $this->rows;
	}
}