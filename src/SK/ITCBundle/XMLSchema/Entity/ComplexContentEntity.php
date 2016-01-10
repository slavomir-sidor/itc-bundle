<?php

/**
 * SK ITCBundle XML Schema Entity Complex Content
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\XMLSchema\Entity;

use SK\ITCBundle\XMLSchema\Entity;

class ComplexContentEntity extends Entity
{

	/**
	 * SK ITCBundle XML Schema Entity Complex Content Name
	 *
	 * @var string
	 */
	protected $elementTagName = 'complexContent';

	/**
	 *
	 * @var AnnotationEntity[]
	 */
	protected $annotation;

	/**
	 *
	 * @var RestrictionEntity[]
	 */
	protected $restriction;

	/**
	 *
	 * @var ExtensionEntity[]
	 */
	protected $extension;

}