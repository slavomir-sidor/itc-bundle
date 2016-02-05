<?php
/**
 * SK ITCBundle Command Code Abstract Reflection
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\REST;

use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use SK\ITCBundle\Code\Reflection;
use SK\ITCBundle\Command\TableCommand;

class EntityCommand extends RESTCommand
{
	/**
	 *
	 * {@inheritDoc}
	 *
	 * @see \SK\ITCBundle\Command\TableCommand::getColumns()
	 */
	protected function getColumns()
	{
		return [
			'name' => 'Name',
			'base'=>'Base',
			'url' => 'Url',
			'methods' => 'Methods',
			'schemes'=>'Security',
			'description' => 'Description'
		];
	}

	/**
	 *
	 * {@inheritDoc}
	 *
	 * @see \SK\ITCBundle\Command\TableCommand::getRows()
	 */
	protected function getRows()
	{
		$apiDefinition = $this->getApiDefinition();
		$outputDirectory = $this->getInput()->getOption( 'outputDirectory' );
		$namespace = $this->getInput()->getOption( 'namespace' );
		$rows=$this->itemsToRows( $apiDefinition->getSchemaCollections() );
		return $rows;
	}

	/**
	 *
	 * @param \Raml\Resource[] $items
	 */
	private function itemsToRows( $items )
	{

		$rows = [];

		foreach( $items as $item )
		{
			foreach ($item as $json){
				$item=json_decode($json);
			}

			continue;
			$row = [];
			$row['name'] = $item->getDisplayName();
			$row['base'] = implode(",", $item->getBaseUriParameters());
			$row['url'] = $item->getUri();
			$row['methods'] = implode( ",", array_keys( $item->getMethods() ) );
			$row['schemes'] = implode( ",", array_keys( $item->getSecuritySchemes() ) );
			$row['description'] = $item->getDescription();

			$rows[] = $row;

			if( $item->getResources() )
			{
				$rows = array_merge( $rows, $this->itemsToRows( $item->getResources() ) );
			}
		}
		return $rows;
	}
}