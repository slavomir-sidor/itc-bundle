<?php

/**
 * SK ITCBundle XML Schema Entity AttributeEntity
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\ORM\XMLSchema\Entity;

use SK\ITCBundle\ORM\XMLSchema\Entity;

class AttributeEntity extends Entity
{

	/**
	 * SK ITCBundle XML Schema Entity AttributeEntity Name
	 *
	 * @var string
	 */
	protected $elementTagName = 'attribute';

	/**
	 *
	 * @var AnnotationEntity[]
	 */
	protected $annotation;

	/**
	 *
	 * @var WhiteSpaceAttrsEntity[]
	 */
	protected $whiteSpaceAttrs;

}