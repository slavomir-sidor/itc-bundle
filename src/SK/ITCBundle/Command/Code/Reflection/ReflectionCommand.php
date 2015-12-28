<?php

/**
 * SK ITCBundle Command Code Abstract Reflection
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Reflection;

use SK\ITCBundle\Command\Code\CodeCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Finder\SplFileInfo;
use Symfony\Component\Console\Helper\Table;
use TokenReflection\ReflectionMethod;
use Symfony\Component\Console\Helper\ProgressBar;
use Symfony\Component\Console\Helper\TableSeparator;
use Symfony\Component\Console\Helper\TableCell;
use Symfony\Component\DependencyInjection\Variable;

abstract class ReflectionCommand extends CodeCommand
{

	/**
	 *
	 * @param InputInterface $input
	 * @param OutputInterface $output
	 */
	protected function executeAttributesReflection()
	{

		$columns = array(
			'Class',
			'Attribute',
			'Accessibility',
			'Static'
		);
		$rows = array();

		foreach( $this->getClassReflections() as $classReflection )
		{
			$attributesReflections = $classReflection->getProperties();

			foreach( $attributesReflections as $attributesReflection )
			{
				$rows[] = array(
					$classReflection->getName(),
					$attributesReflection->getName(),
					$attributesReflection->isPrivate() ? "Private" : $attributesReflection->isProtected() ? "Protected" : "Public",
					$attributesReflection->isStatic() ? "Yes" : "No"
				);
			}
		}
		$this->writeTable( $rows, $columns, 120 );
		$this->writeExceptions();

	}

	/**
	 *
	 * @param InputInterface $input
	 * @param OutputInterface $output
	 */
	protected function executeOperationsAttributesReflection()
	{

		$rows = [];
		$reflections = $this->getClassReflections();

		foreach( $reflections as $classReflection )
		{
			$operationReflections = $classReflection->getMethods();

			foreach( $operationReflections as $operationReflection )
			{

				$attributeReflections = $operationReflection->getParameters();

				foreach( $attributeReflections as $attributeReflection )
				{
					$row = array(
						$classReflection->getName(),
						$operationReflection->getName(),
						$attributeReflection->getName(),
						// $attributeReflection->getType(),
						$attributeReflection->isDefaultValueAvailable() ? is_string( $attributeReflection->getDefaultValue() ) ? $attributeReflection->getDefaultValue() : "" : ""
					);
					// ($operationReflections->getDocBlock()) ? $classOperationReflection->getDocBlock()->getShortDescription() : ""

					$rows[] = $row;
				}
			}
		}

		$this->writeTable( $rows, array(
			'Class Name',
			'Operation',
			'Attribute',
			'Type',
			'Default'
		) );
		$this->writeExceptions();

	}
}