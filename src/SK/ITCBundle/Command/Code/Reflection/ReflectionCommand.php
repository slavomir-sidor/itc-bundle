<?php

namespace SK\ITCBundle\Command\Code\Reflection;

use SK\ITCBundle\Command\Code\CodeCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Finder\SplFileInfo;
use Symfony\Component\Console\Helper\Table;
use TokenReflection\ReflectionMethod;

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
	public function __construct( $name = "src:reflect", $description = "ITCCloud Reflect Source Code" )
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
		$tableHeader = array( 
				'Class Namespace Name',
				'Parent',
				'Interfaces' 
		);
		$tableRows = array();
		foreach( $this->getClassReflections() as $classReflection )
		{
			$tableRows[] = array( 
					$classReflection->getName(),
					implode( ", ", $classReflection->getParentClassNameList() ),
					implode( ", ", $classReflection->getInterfaceNames() ) 
			);
		}
		
		$table = new Table( $this->getOutput() );
		$table->setHeaders( $tableHeader );
		$table->setRows( $tableRows );
		$table->render();
		
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
		
		$tableHeader = array( 
				'Namespace Name',
				'Class',
				'Attribute',
				'Accessibility',
				'Static' 
		);
		
		$tableRows = array();
		foreach( $classReflections as $classReflection )
		{
			$attributesReflections = $classReflection->getProperties();
			foreach( $attributesReflections as $attributesReflection )
			{
				$tableRows[] = array( 
						$classReflection->getNamespaceName(),
						$classReflection->getShortName(),
						$attributesReflection->getName(),
						$attributesReflection->isPrivate() ? "Private" : $attributesReflection->isProtected() ? "Protected" : "Public",
						$attributesReflection->isStatic() ? "Yes" : "No" 
				);
			}
		}
		
		$table = new Table( $this->getOutput() );
		$table->setHeaders( $tableHeader );
		$table->setRows( $tableRows );
		$table->render();
		$this->writeExceptions();
	}
	
	/**
	 *
	 * @param InputInterface $input        	
	 * @param OutputInterface $output        	
	 */
	protected function executeOperationsReflection()
	{
		$classReflections = $this->getClassReflections();
		
		$tableHeader = array( 
				'Namespace Name',
				'Class',
				'Operation',
				'Accessibility',
				'Abstract',
				'Static',
				'Returns' 
		);
		
		$tableRows = array();
		$table = new Table( $this->getOutput() );
		$table->setHeaders( $tableHeader );
		
		foreach( $this->getOperationsReflections() as $operationReflection )
		{
			
			$tableRows[] = array( 
					$operationReflection->getDeclaringClass()->getNamespaceName(),
					$operationReflection->getDeclaringClass()->getShortName(),
					$operationReflection->getName(),
					$operationReflection->isPrivate() ? "Private" : $operationReflection->isProtected() ? "Protected" : "Public",
					$operationReflection->isAbstract() ? "Yes" : "No",
					$operationReflection->isStatic() ? "Yes" : "No",
					"" 
			);
		}
		
		$table->setRows( $tableRows );
		$table->render();
		$this->writeExceptions();
	}
	
	/**
	 *
	 * @param InputInterface $input        	
	 * @param OutputInterface $output        	
	 */
	protected function executeOperationsAttributesReflection()
	{
		$classReflections = $this->getClassReflections();
		$tableHeader = array( 
				'Namespace Name',
				'Class',
				'Operation',
				'Attribute',
				'Type',
				'Default' 
		);
		
		$tableRows = array();
		foreach( $classReflections as $classReflection )
		{
			$operationReflections = $classReflection->getMethods();
			
			foreach( $operationReflections as $operationReflection )
			{
				
				$attributeReflections = $operationReflection->getParameters();
				
				foreach( $attributeReflections as $attributeReflection )
				{
					$row = array( 
							$classReflection->getNamespaceName(),
							$classReflection->getShortName(),
							$operationReflection->getName(),
							$attributeReflection->getName(),
							$attributeReflection->getType(),
							$attributeReflection->isDefaultValueAvailable() ? $attributeReflection->getDefaultValue() : "" 
					);
					// ($operationReflections->getDocBlock()) ? $classOperationReflection->getDocBlock()->getShortDescription() : ""
					
					$tableRows[] = $row;
				}
			}
		}
		$table = new Table( $this->getOutput() );
		$table->setHeaders( $tableHeader );
		$table->setRows( $tableRows );
		$table->render();
		$this->writeExceptions();
	}
	
	/**
	 *
	 * @param InputInterface $input        	
	 * @param OutputInterface $output        	
	 */
	protected function executeNamespaceReflection()
	{
		$classReflections = $this->getClassReflections();
		
		$tableHeader = array( 
				'Namespace Name',
				'Class Count' 
		);
		
		$tableRows = array();
		foreach( $classReflections as $classReflection )
		{
			
			if( ! isset( $tableRows[ $classReflection->getNamespaceName() ] ) )
			{
				$tableRows[ $classReflection->getNamespaceName() ] = array( 
						$classReflection->getNamespaceName(),
						0 
				);
			}
			++ $tableRows[ $classReflection->getNamespaceName() ][ 1 ];
		}
		
		$table = new Table( $this->getOutput() );
		$table->setHeaders( $tableHeader );
		$table->setRows( $tableRows );
		$table->render();
		$this->writeExceptions();
	}
	
	/**
	 *
	 * @param InputInterface $input        	
	 * @param OutputInterface $output        	
	 */
	protected function executeFilesReflection()
	{
		$tableHeader = array( 
				implode( "|", $this->getInput()->getArgument( 'src' ) ),
				"Owner",
				"Group",
				"Permissions" 
		);
		$tableRows = array();
		/* @var $file SplFileInfo*/
		foreach( $this->getFinder()->files() as $file )
		{
			$row = array( 
					$file->getRelativePathname(),
					$file->getOwner(),
					$file->getGroup(),
					$file->getPerms() 
			);
			$tableRows[] = $row;
		}
		
		$table = new Table( $this->getOutput() );
		$table->setHeaders( $tableHeader );
		$table->setRows( $tableRows );
		$table->render();
		
		$this->writeExceptions();
	}
}