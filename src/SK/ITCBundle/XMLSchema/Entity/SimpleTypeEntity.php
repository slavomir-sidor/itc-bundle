<?php
/**
 * SK ITCBundle XML Schema Simple Type
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\XMLSchema\Entity;

use SK\ITCBundle\XMLSchema\Entity;

class SimpleTypeEntity extends Entity
{

	/**
	 * SK ITCBundle XML Schema Entity Simple Type Name
	 *
	 * @var string
	 */
	protected $elementTagName = 'whiteSpaceAttrs';

	/**
	 *
	 * @var AnnotationEntity
	 */
	protected $annotation;

	/**
	 *
	 * @var RestrictionEntity
	 */
	protected $restriction;

	/**
	 *
	 * @var ListEntity
	 */
	protected $list;

	/**
	 *
	 * @var UnionEntity
	 */
	protected $union;
}