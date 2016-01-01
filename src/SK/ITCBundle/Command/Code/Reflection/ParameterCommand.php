<?php

/**
 * SK ITCBundle Command Code Reflection Operations Attributes
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Reflection;

use TokenReflection\Php\ReflectionParameter;

class ParameterCommand extends ReflectionCommand
{

	protected $columns = array(
		'Class Name',
		'Operation',
		'Parameter',
		'Type',
		'Default'
	);


	protected function getRows()
	{
		if( null === $this->rows )
		{
			$rows = [];

			$reflections = $this->getReflection()->getParameters();

			/* @var $reflection  ReflectionParameter */
			foreach( $reflections as $reflection )
			{
				$row = [];

				$row[ 'Class' ]=$reflection->getDeclaringClassName();
				$row[ 'Operation' ] = $reflection->getDeclaringFunctionName();
				$row[ 'Parameter' ] = $reflection->getName();
				$row[ 'Type' ] = $reflection->getPrettyName();
				$row[ 'Default' ] = $reflection->getDefaultValueDefinition();

				$rows[] = $row;
			}

			$this->setRows( $rows );
		}

		return $this->rows;
	}
}