<?php
/**
 * SK ITCBundle XML Schema Entity ExtensionEntity
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\XMLSchema\Entity;

use SK\ITCBundle\XMLSchema\Entity;
use Doctrine\Common\Annotations\Annotation\Attribute;

class ExtensionEntity extends Entity
{

	/**
	 * SK ITCBundle XML Schema Entity Simple Content Name
	 *
	 * @var string
	 */
	protected $elementTagName = 'extension';

	/**
	 *
	 * @var AnnotationEntity[]
	 */
	protected $annotation;

	/**
	 *
	 * @var AllEntity[]
	 */
	protected $all;

	/**
	 *
	 * @var ChoiceEntity[]
	 */
	protected $choice;

	/**
	 *
	 * @var SequenceEntity[]
	 */
	protected $sequence;

	/**
	 *
	 * @var GroupEntity[]
	 */
	protected $group;

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
	 * @var AnyAttributeEntity[]
	 */
	protected $anyAttribute;
}
