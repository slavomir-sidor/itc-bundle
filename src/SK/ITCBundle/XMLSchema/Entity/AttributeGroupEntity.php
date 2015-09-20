<?php
/**
 * SK ITCBundle XML Schema Entity Attribute Group
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\XMLSchema\Entity;

use SK\ITCBundle\XMLSchema\Entity;

class AttributeGroupEntity extends Entity
{

	/**
	 * SK ITCBundle XML Schema Entity Attribute Group Name
	 *
	 * @var string
	 */
	protected $elementTagName = 'attributeGroup';

	/**
	 *
	 * @var AnnotationEntity[]
	 */
	protected $annotation;

	/**
	 *
	 * @var AttributeEntity[]
	 */
	protected $attribute;

	/**
	 *
	 * @var WhiteSpaceAttrsEntity[]
	 */
	protected $whiteSpaceAttrs;
}