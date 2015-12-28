<?php

namespace SK\ITCBundle\Code\Reflection\Collection;

use PhpCollection\Map;
use TokenReflection\Php\ReflectionMethod;

class OperationCollection extends Map
{
	/**
	 *
	 * @var ReflectionMethod[]
	 */
	protected $elements;
}