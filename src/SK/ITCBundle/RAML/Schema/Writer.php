<?php
namespace SK\ITCBundle\RAML\Schema;

use Raml\ApiDefinition;
use Monolog\Logger;
use JMS\Serializer\Serializer;
use Raml\Resource;
use Raml\Method;

class Writer
{
	/**
	 *
	 * @var Serializer
	 */
	protected $serializer;

	/**
	 *
	 * @param Logger $logger
	 * @param Serializer $serializer
	 */
	public function __construct(Logger $logger, Serializer $serializer)
	{
		parent::__construct ( $logger );
		$this->setSerializer ( $serializer );
	}

	/**
	 *
	 * @param ApiDefinition $apiDefinition
	 * @param string $file
	 */
	public function write(ApiDefinition $apiDefinition, $filename)
	{
		return file_put_contents ( $filename, $this->serializer ( $apiDefinition ) );
	}

	/**
	 *
	 * @param ApiDefinition $apiDefinition
	 */
	public function serialize(ApiDefinition $apiDefinition, $output="yml")
	{
		$serializer = $this->getSerializer ();
		return $serializer->serialize ( $apiDefinition, $output );
	}

	/**
	 *
	 * @param ApiDefinition $apiDefinition
	 * @param string $file
	 */
	public function resource(Resource $resource)
	{
		$serializer = $this->getSerializer ();
		$structure = [ ];
		$structure ['displayName'] = $resource->getDisplayName ();
		$structure ['description'] = $resource->getDescription ();
		$structure ['uriParameters'] = $resource->getBaseUriParameters ();

		foreach ( $resource->getMethods () as $method )
		{
			$structure [$method->getType ()] = $this->serializeMethod ( $method );
		}

		$resource->getResources ();
		$resource->getSecuritySchemes ();
		$resource->getUri ();

		$structure ['responses'] = array (
			'200'
		);
	}
	private function serializeMethod(Method $method)
	{
		return [ ];
	}

	/**
	 *
	 * @return \JMS\Serializer\Serializer
	 */
	public function getSerializer()
	{
		return $this->serializer;
	}

	/**
	 *
	 * @param Serializer $serializer
	 * @return \ActionPlanner\ConsoleBundle\RAML\Writer
	 */
	public function setSerializer(Serializer $serializer)
	{
		$this->serializer = $serializer;
		return $this;
	}
}