<?php

namespace SK\ITCBundle\Command\Code\Reflection;

use SK\ITCBundle\Command\Code\CodeCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Finder\SplFileInfo;
use Symfony\Component\Console\Helper\Table;
use TokenReflection\ReflectionMethod;
use Symfony\Component\Console\Helper\ProgressBar;

/**
 * SK ITCBundle Command Code Abstract Reflection
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
abstract class ReflectionCommand extends CodeCommand
{

	/**
	 * Constructs SK ITCBundle Command Code Abstract Reflection
	 *
	 * @param string $name
	 *        	SK ITCBundle Command Code Abstract Reflection Name
	 * @param string $description
	 *        	SK ITCBundle Command Code Abstract Reflection Description
	 */
	public function __construct(
		$name = "src:reflect",
		$description = "ITCCloud Reflect Source Code" )
	{

		parent::__construct( $name, $description );

	}

	/**
	 *
	 * @param InputInterface $input
	 * @param OutputInterface $output
	 */
	protected function executeClassReflection()
	{

		$header = array(
			'Type',
			'Namespace Name',
			'Final',
			'Abstract',
			'Parent',
			'Interfaces'
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

			$row[] = $classReflection->getName();

			$row[] = $classReflection->isFinal() ? "Yes" : "No";
			$row[] = $classReflection->isAbstract() ? "Yes" : "No";

			$row[] = implode( ",\n", $classReflection->getParentClassNameList() );
			$row[] = implode( ", ", $classReflection->getInterfaceNames() );

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

		$classReflections = $this->getClassReflections();

		$header = array(
			'Namespace Name',
			'Class',
			'Attribute',
			'Accessibility',
			'Static'
		);
		$rows = array();

		foreach( $classReflections as $classReflection )
		{
			$attributesReflections = $classReflection->getProperties();

			foreach( $attributesReflections as $attributesReflection )
			{
				$rows[] = array(

					$classReflection->getNamespaceName(),
					$classReflection->getShortName(),
					$attributesReflection->getName(),
					$attributesReflection->isPrivate() ? "Private" : $attributesReflection->isProtected() ? "Protected" : "Public",
					$attributesReflection->isStatic() ? "Yes" : "No"
				);
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
	protected function executeOperationsReflection()
	{

		$header = array(
			'Class Name',
			'Operation',
			'Accessibility',
			'Abstract',
			'Static',
			'Returns'
		);
		$rows = [];
		$reflection = $this->getOperationsReflections();

		foreach( $reflection as $operationReflection )
		{

			$row = array(
				$operationReflection->getDeclaringClass()
					->getName(),
				$operationReflection->getName(),
				$operationReflection->isPrivate() ? "Private" : $operationReflection->isProtected() ? "Protected" : "Public",
				$operationReflection->isAbstract() ? "Yes" : "No",
				$operationReflection->isStatic() ? "Yes" : "No",
				""
			);

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

		$header = array(
			'File',
			"Owner",
			"Group",
			"Permissions"
		);

		$rows = [];

		/* @var $file SplFileInfo*/
		foreach( $this->getFinder()
			->files() as $file )
		{

			$row = array(
				$file->getRelativePathname(),
				$file->getOwner(),
				$file->getGroup(),
				$file->getPerms()
			);

			$rows[] = $row;
		}

		$this->writeTable( $rows, $header );
		$this->writeExceptions();

	}

}