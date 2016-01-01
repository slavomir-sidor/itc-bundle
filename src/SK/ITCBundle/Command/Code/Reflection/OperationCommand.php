<?php

/**
 * SK ITCBundle Command Code Reflection Operations
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Reflection;

use TokenReflection\Php\ReflectionMethod;

class OperationCommand extends ReflectionCommand
{

	protected $columns = array(
		'Class',
		'Accessibility',
		'Abstract',
		'Static',
		'Operation',
		'Parameters',
		'Returns'
	);

	protected function getRows()
	{
		if( null === $this->rows )
		{
			$rows = [];

			$reflections = $this->getReflection()
				->getOperations();

			/* @var $reflection ReflectionMethod */
			foreach( $reflections as $reflection )
			{
				$row = [];

				$parameters = $reflection->getParameters();
				$operationsParameters = [];
				foreach( $parameters as $parameter )
				{
					$operationsParameters[] = $parameter->getName();
				}

				$row[ 'Class' ]=$reflection->getDeclaringClassName();
				$row[ 'Accessibility' ] =self::getAccessibility($reflection);
				$row[ 'Abstract' ] =self::getAbstract($reflection);
				$row[ 'Static' ] =self::getStatic($reflection);
				$row[ 'Operation' ] = $reflection->getName();
				$row[ 'Parameters' ] = implode( ', ', $operationsParameters );
				$row[ 'Returns' ] = '';
				//(isset($annotations['return']) && isset($annotations['return'][0]))?$annotations['return'][0]:''

				$rows[] = $row;
			}

			$this->setRows( $rows );
		}

		return $this->rows;
	}
}