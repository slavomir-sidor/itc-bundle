<?php
/**
 * SK ITCBundle Command Mylyn Report Command
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Mylyn;

use SK\ITCBundle\Command\Code\Reflection\ReflectionCommand;
use Symfony\Component\Console\Input\InputOption;
use SK\ITCBundle\Mylyn\Task;
use JMS\Serializer\SerializerBuilder;

class ReportCommand extends ReflectionCommand
{

	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::configure()
	 */
	protected function configure()
	{
		parent::configure();

		$outputTypeDefault = "html";
		$outputFileDefault = sprintf( "%s/%s/%s/daily.%s", $_SERVER['HOME'], 'Documents/AP/Pivotal', date( 'Y-m-d' ), $outputTypeDefault );

		$this->addOption( "outputType", "ou", InputOption::VALUE_OPTIONAL, "Report Output type: html|txt.", $outputTypeDefault );
		$this->addOption( "outputFile", "of", InputOption::VALUE_OPTIONAL, "Report Output file.", $outputFileDefault );

		$this->getDefinition()
			->getOption( 'fileSuffix' )
			->setDefault( "context-state.xml" );

		$this->getDefinition()
			->getOption( 'ignoreDotFiles' )
			->setDefault( FALSE );

		$this->getDefinition()
			->getOption( 'date' )
			->setDefault( "since yesterday" );

		$srcDefault = array(
			sprintf( "%s/domains/.metadata", $_SERVER['HOME'] )
		);
		$this->getDefinition()
			->getArgument( 'src' )
			->setDefault( $srcDefault );
	}

	/**
	 *
	 * {@inheritDoc}
	 *
	 * @see \SK\ITCBundle\Command\TableCommand::getColumns()
	 */
	protected function getColumns()
	{
		return array(
			'Task ID',
			'Status',
			'Title',
			'Hours',
			'Modified'
		);
	}

	/**
	 *
	 * {@inheritDoc}
	 *
	 * @see \SK\ITCBundle\Command\TableCommand::getRows()
	 */
	protected function getRows()
	{
		if( null === $this->rows )
		{
			$files = $this->getReflection()
				->getFiles()
				->toArray();

			$outputType = $this->getInput()->getOption( 'outputType' );
			$outputFile = $this->getInput()->getOption( 'outputType' );

			$xslDir = $this->getContainer()
				->get( 'kernel' )
				->locateResource( '@SKITCBundle/Resources/xsl/report' );

			$xslFile = sprintf( "%s/%s.xsl", $xslDir, $outputType );

			$tasks = [];

			foreach( $files as $row )
			{
				$xmldoc = new \DOMDocument();
				$xmldoc->load( $row['File'] );

				$xsldoc = new \DOMDocument();
				$xsldoc->load( $xslFile );

				$xsl = new \XSLTProcessor();
				$xsl->importStyleSheet( $xsldoc );
				$report = $xsl->transformToDoc( $xmldoc );
				$report->save( $outputFile );

				$serializer = SerializerBuilder::create()->build();
				$task = $serializer->deserialize( $xmldoc->saveXML(), 'SK\ITCBundle\Mylyn\ContextState', 'xml' );
				// $task = new ContextState( $row );

				$tasks[] = $task->toArray();
			}

			$this->setRows( $tasks );
		}

		return $this->rows;
	}
}