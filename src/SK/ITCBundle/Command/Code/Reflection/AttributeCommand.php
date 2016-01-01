<?php
/**
 * SK ITCBundle Command Code Reflection Attributes
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Reflection;

use TokenReflection\Php\ReflectionProperty;

class AttributeCommand extends ReflectionCommand
{

	protected $columns = array(
		'Class',
		'Attribute',
		'Accessibility',
		'Static',
		'Default'
	);

	protected function getRows()
	{
		if( null === $this->rows )
		{
			$rows = [];

			$reflections = $this->getReflection()->getAttributes();

			/* @var $reflection ReflectionProperty */
			foreach( $reflections as $reflection )
			{
				$row = [];

				$row[ 'Class' ] = $reflection->getDeclaringClassName();
				$row[ 'Attribute' ] = $reflection->getName();
				$row[ 'Accessibility' ] = self::getAccessibility( $reflection );
				$row[ 'Static' ] = self::getStatic( $reflection );
				$row[ 'Default' ] = is_array($reflection->getDefaultValue())?'array':$reflection->getDefaultValue();

				$rows[] = $row;
			}

			$this->setRows( $rows );
		}

		return $this->rows;
	}
}