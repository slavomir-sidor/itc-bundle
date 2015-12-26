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
	protected function executeClassReflection()
	{

		$header = array(
			'PHP Object',
			'Final',
			'Abstract',
			'Namespace Name',
			'Parent',
			'Implements Interfaces'
		);

		$rows = array();

		foreach( $this->getClassReflections() as $classReflection )
		{
			$row = [];
			if( $classReflection->isTrait() )
			{
				$row[] = "Trait";
			}
			elseif( $classReflection->isInterface() )
			{
				$row[] = "Interface";
			}
			else
			{
				$row[] = "Class";
			}
			$row[] = $classReflection->isFinal() ? "Final" : "";
			$row[] = $classReflection->isAbstract() ? "Abstract" : "";
			$row[] = $classReflection->getName();
			$row[] = implode( "\n", $classReflection->getParentClassNameList() );
			$row[] = implode( "\n", $classReflection->getInterfaceNames() );

			$rows[] = $row;
		}

		$this->writeTable( $rows, $header );
		$this->writeExceptions();

	}

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
	protected function executeOperationsReflection()
	{

		$rows = [];
		$declaringClassName = "";

		foreach( $this->getOperationsReflections() as $operationReflection )
		{
			$operationsParametersReflections = $operationReflection->getParameters();
			$operationsParameters = [];
			foreach( $operationsParametersReflections as $parameter )
			{
				$operationsParameters[] = $parameter->getName();
			}
			$annotations = $operationReflection->getAnnotations();
			$accesibility="";
			if($operationReflection->isPrivate()){
				$accesibility="Private";
			}
			if($operationReflection->isProtected()){
				$accesibility="Protected";
			}
			if($operationReflection->isPublic()){
				$accesibility="Public";
			}

			$rows[] = array(
				$accesibility,
				$operationReflection->isAbstract() ? "Abstract" : "",
				$operationReflection->isStatic() ? "Static" : "",
				sprintf( '%s::%s', $operationReflection->getDeclaringClassName(), $operationReflection->getName() ),
				implode( ', ', $operationsParameters ),
				(isset($annotations['return']) && isset($annotations['return'][0]))?$annotations['return'][0]:''
			);
		}

		$this->writeTable( $rows, array(
			'Accessibility',
			'Abstract',
			'Static',
			'Operation',
			'Parameters',
			'Returns'
		), 120 );

		$this->writeExceptions();
	}

	/**
	 *
	 * @param InputInterface $input
	 * @param OutputInterface $output
	 */
	protected function executeOperationsAttributesReflection()
	{

		$header = array(
			'Class Name',
			'Operation',
			'Attribute',
			'Type',
			'Default'
		);

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

		$this->writeTable( $rows, $header );
		$this->writeExceptions();

	}

	/**
	 *
	 * @param InputInterface $input
	 * @param OutputInterface $output
	 */
	protected function executeNamespaceReflection()
	{

		$header = array(
			'Namespace Name',
			'Objects Count'
		);

		$reflections = $this->getClassReflections();

		$rows = [];

		foreach( $reflections as $classReflection )
		{

			if( ! isset( $rows[ $classReflection->getNamespaceName() ] ) )
			{
				$rows[ $classReflection->getNamespaceName() ] = array(

					$classReflection->getNamespaceName(),
					0
				);
			}
			++ $rows[ $classReflection->getNamespaceName() ][ 1 ];
		}

		$this->writeTable( $rows, $header );
		$this->writeExceptions();

	}

	/**
	 *
	 * @param InputInterface $input
	 * @param OutputInterface $output
	 */
	protected function executeFilesReflection()
	{

		$rows = [];
		foreach( $this->getFileRelections() as $fileReflection )
		{
			$file = new \SplFileInfo( $fileReflection->getName() );
			$row = array(
				$fileReflection->getPrettyName(),
				$file->getOwner(),
				$file->getGroup(),
				$file->getPerms(),
				date( "d.m.Y h:m:s", $file->getCTime() ),
				date( "d.m.Y h:m:s", $file->getMTime() )
			);
			$rows[] = $row;
		}

		$this->writeTable( $rows, array(
			"Files",
			"Owner",
			"Group",
			"Permissions",
			"Created",
			"Modified"
		), 120 );

		$this->writeExceptions();

	}

}