<?php

/**
 * SK ITCBundle Command Code Abstract Generator
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator;

use SK\ITCBundle\Command\Code\Reflection\ReflectionCommand;
use SK\ITCBundle\Code\Generator;
use SK\ITCBundle\Code\Reflection;
use Monolog\Logger;

abstract class GeneratorCommand extends ReflectionCommand
{

	/**
	 *
	 * @var Generator
	 */
	protected $generator;

	/**
	 * Constructs SK ITCBundle Abstract Command
	 *
	 * @param string $name
	 *        	SK ITCBundle Abstract Command Name
	 * @param string $description
	 *        	SK ITCBundle Abstract Command Description
	 * @param Logger $logger
	 *        	SK ITCBundle Abstract Command Logger
	 * @param Reflection $reflection
	 *        	SK ITCBundle Abstract Command Reflection
	 */
	public function __construct( $name, $description, Logger $logger, Reflection $reflection, Generator $generator )
	{
		parent::__construct( $name, $description, $logger, $reflection );

		$this->setGenerator( $generator );
	}

	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::configure()
	 */
	protected function configure()
	{
		parent::configure();
	}

	/**
	 *
	 * @return the Generator
	 */
	protected function getGenerator()
	{
		return $this->generator;
	}

	/**
	 *
	 * @param Generator $generator
	 */
	protected function setGenerator( Generator $generator )
	{
		$this->generator = $generator;
		return $this;
	}
}