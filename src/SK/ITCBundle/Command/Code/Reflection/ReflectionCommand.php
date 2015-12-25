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
			$row[] = $classReflection->isFinal() ? "Yes" : "No";
			$row[] = $classReflection->isAbstract() ? "Yes" : "No";

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
			'Class Operation',
			'Accessibility',
			'Abstract',
			'Static',
			'Returns'
		);
		$rows = [];
		$reflection = $this->getOperationsReflections();

		$className="";

		foreach( $reflection as $operationReflection )
		{
			$operationReflection=$operationReflection->getDeclaringClass()
					->getName();
			if($className!=){
				$className
			}
			$rows[] = $row;
			$row=array();

			$row = array(
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
			"Permissions",
			"Created",
			"Modified"
		);

		$rows = [];

		/* @var $file \SplFileInfo*/
		foreach( $this->getFinder()
			->files() as $file )
		{
			$row = array(
				$file->getRelativePathname(),
				$file->getOwner(),
				$file->getGroup(),
				$file->getPerms(),
				date( "d.m.Y h:m:s", $file->getCTime() ),
				date( "d.m.Y h:m:s", $file->getMTime() )
			);

			$rows[] = $row;
		}

		$this->writeTable( $rows, $header );
		$this->writeExceptions();
	}
}