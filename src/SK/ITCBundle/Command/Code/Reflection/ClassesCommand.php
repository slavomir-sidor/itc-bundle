<?php
/**
 * SK ITCBundle Command Code Reflection Classes
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Reflection;

use TokenReflection\Php\ReflectionClass;

class ClassesCommand extends ReflectionCommand
{

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
	protected function getClasses()
	{
		if( NULL === $this->rows )
		{
			$rows = [];

			/* @var $reflection ReflectionClass[] */
			foreach( $this->getReflection()
				->getClasses() as $reflection )
			{
				$row = [];

				$row[ 'object' ] = self::getObjectType( $reflection );
				$row[ 'final' ] = $reflection->isFinal() ? "Final" : "";
				$row[ 'abstract' ] = $reflection->isAbstract() ? "Abstract" : "";
				$row[ 'name' ] = $reflection->getName();
				$row[ 'parent' ] = implode( "\n", $reflection->getParentClassNameList() );
				$row[ 'interface' ] = implode( "\n", $reflection->getInterfaceNames() );

				$rows[] = $row;
			}

			$this->setRows( $rows );
		}
		return $this->classes;
	}
}