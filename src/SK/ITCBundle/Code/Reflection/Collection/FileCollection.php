<?php

namespace SK\ITCBundle\Code\Reflection\Collection;

use PhpCollection\Map;
use TokenReflection\ReflectionFile;

class FileCollection extends Map
{
	/**
	 *
	 * @var ReflectionFile[]
	 */
	protected $elements;
}