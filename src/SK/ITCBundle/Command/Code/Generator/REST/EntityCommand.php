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
			'id' => 'Id',
			'type' => 'Type',
			'properties' => 'Properties',
			'render' => 'Rendered'
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
		$outputDirectory.=implode(DIRECTORY_SEPARATOR, explode("\\", $namespace));

		$rows = $this->itemsToRows( $apiDefinition->getSchemaCollections() );
		foreach( $apiDefinition->getSchemaCollections() as $name=>$item )
		{
			$className=ucfirst($name);
			var_dump($name);
			$filename=$outputDirectory.DIRECTORY_SEPARATOR.$className.'.php';
			$template = $this->getContainer()
				->get( 'kernel' )
				->locateResource( '@SKITCBundle/Resources/generator/rest/Entity.php.twig' );
			$row['render'] = "Yes";
		}

		return $rows;
	}

	/**
	 *
	 * @param \Raml\Resource[] $items
	 */
	protected function itemsToRows( $items )
	{
		$rows = [];

		foreach( $items as $item )
		{
			foreach( $item as $json )
			{
				$item = json_decode( $json );
			}

			$rows[] = $this->schemaToRow( $item );
		}

		return $rows;
	}

	/**
	 *
	 * @param stdClass $item
	 * @return string[]|NULL[]
	 */
	protected function schemaToRow( $item )
	{
		$row = [];
		$row['id'] = $item->id;
		$row['type'] = $item->type;

		switch( $item->type )
		{
			case 'array':
				{
					$row['properties'] = var_Export( $item->items, true );
					break;
				}
			case 'object':
			default:
				{
					if( isset( $item->properties ) )
					{
						$row['properties'] = $this->propertiesToColumn( $item->properties );
					}
					break;
				}
		}

		return $row;
	}

	/**
	 *
	 * @param stdClass $item
	 * @return string
	 */
	protected function propertiesToColumn( $properties )
	{
		$properties = get_object_vars( $properties );
		$column = "";
		foreach( $properties as $name => $property )
		{
			$column .= sprintf( "%s:\n  Required: %s\n  Type: %s\n\n", $name, ( $property->required ) ? "Yes" : "No", $property->type );
			// $column.=print_R($property,true);
		}
		return $column;
	}
}