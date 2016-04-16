<?php

/**
 * SK ITCBundle XML Schema Entity RestrictionEntity
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\ORM\XMLSchema\Entity;

use SK\ITCBundle\ORM\XMLSchema\Entity;

class RestrictionEntity extends Entity
{

	/**
	 * SK ITCBundle XML Schema Entity RestrictionEntity Tag Name
	 *
	 * @var string
	 */
	protected $elementTagName = 'restriction';

	/**
	 *
	 * @var AnyAttributeEntity[]
	 */
	protected $anyAttribute;

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
	 * @var EnumerationEntity[]
	 */
	protected $enumeration;

	/**
	 *
	 * @var AttributeEntity[]
	 */
	protected $attribute;

	/**
	 *
	 * @var GroupEntity[]
	 */
	protected $group;

	/**
	 *
	 * @var MinLengthEntity[]
	 */
	protected $minLength;

}