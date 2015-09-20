<?php
/**
 * SK ITCBundle XML SchemaEntity Entity SchemaEntity
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\XMLSchema\Entity;

use SK\ITCBundle\XMLSchema\Entity;
use Doctrine\Common\Annotations\Annotation\Attribute;

class SchemaEntity extends Entity
{

	/**
	 * SK ITCBundle XML SchemaEntity Tag Name
	 *
	 * @var string
	 */
	protected $elementTagName = 'schema';

	/**
	 *
	 * @var IncludeEntity[]
	 */
	protected $include;

	/**
	 *
	 * @var ImportEntity[]
	 */
	protected $import;

	/**
	 *
	 * @var RedefineEntity[]
	 */
	protected $redefine;

	/**
	 *
	 * @var AnnotationEntity[]
	 */
	protected $annotation;

	/**
	 *
	 * @var SimpleTypeEntity[]
	 */
	protected $simpleType;

	/**
	 *
	 * @var ComplexType[]
	 */
	protected $complexType;

	/**
	 *
	 * @var ElementEntity[]
	 */
	protected $element;

	/**
	 *
	 * @var AttributeEntity[]
	 */
	protected $attribute;

	/**
	 *
	 * @var AttributeGroupEntity[]
	 */
	protected $attributeGroup;

	/**
	 *
	 * @var GroupEntity[]
	 */
	protected $group;

	/**
	 *
	 * @var NotationEntity[]
	 */
	protected $notation;

	/**
	 *
	 * @var WhiteSpaceAttrsEntity
	 */
	protected $whiteSpaceAttrs;
}