<?php

/**
 * SK ITCBundle XML Schema Entity UnionEntity
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\ORM\XMLSchema\Entity;

use SK\ITCBundle\ORM\XMLSchema\Entity;

class UnionEntity extends Entity
{

	/**
	 * SK ITCBundle XML Schema Entity UnionEntity Name
	 *
	 * @var string
	 */
	protected $elementTagName = 'union';

	/**
	 *
	 * @var string
	 */
	protected $id;

	/**
	 *
	 * @var QNamesEntity
	 */
	protected $memberTypes;

	/**
	 *
	 * @var AnnotationEntity
	 */
	protected $annotation;

	/**
	 *
	 * @var SimpleTypeEntity[]
	 */
	protected $simpleType;

	/**
	 *
	 * @var WhiteSpaceAttrsEntity
	 */
	protected $whiteSpaceAttrs;

}