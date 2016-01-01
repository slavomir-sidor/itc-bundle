<?php

namespace SK\ITCBundle\Code\Reflection\Collection;

use PhpCollection\Map;
use TokenReflection\ReflectionNamespace;

class PackageCollection extends Map
{
	/**
	 *
	 * @var ReflectionNamespace[]
	 */
	protected $elements;
}