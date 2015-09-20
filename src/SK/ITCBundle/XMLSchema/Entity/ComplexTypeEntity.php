<?php
/**
 * SK ITCBundle XML Schema Entity Complex Type
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\XMLSchema\Entity;

use SK\ITCBundle\XMLSchema\Entity;

class ComplexTypeEntity extends Entity
{

	/**
	 * SK ITCBundle XML Schema Entity Complex Type Name
	 *
	 * @var string
	 */
	protected $elementTagName = 'complexType';

	/**
	 *
	 * @var string
	 */
	protected $id;

	/**
	 *
	 * @var NCNameEntity
	 */
	protected $name;

	/**
	 * SK ITCBundle XML Schema
	 *
	 * @var BooleanEntity
	 */
	protected $abstract;

	/**
	 *
	 * @var ComplexDerivationSetEntity
	 */
	protected $final;

	/**
	 *
	 * @var ComplexDerivationSetEntity
	 */
	protected $block;

	/**
	 *
	 * @var boolean
	 */
	protected $mixed;

	/**
	 *
	 * @var ComplexTypeAttrsEntity
	 */
	protected $complexTypeAttrs;

	/**
	 *
	 * @var AnnotationEntity
	 */
	protected $annotation;

	/**
	 *
	 * @var SimpleContentEntity
	 */
	protected $simpleContent;

	/**
	 *
	 * @var ComplexContentEntity
	 */
	protected $complexContent;

	/**
	 *
	 * @var SequenceEntity[]
	 */
	protected $sequence;

	/**
	 *
	 * @var AttributeEntity[]
	 */
	protected $attribute;

	/**
	 *
	 * @var AnyAttributeEntity[]
	 */
	protected $anyAttribute;
}