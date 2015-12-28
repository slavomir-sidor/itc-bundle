<?php

namespace SK\ITCBundle\Code\Reflection\Collection;

use PhpCollection\Map;
use TokenReflection\Php\ReflectionClass;

class ClassCollection extends Map{

	/**
	 *
	 * @var ReflectionClass[]
	 */
	protected $elements;
}