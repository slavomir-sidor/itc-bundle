<?php
/**
 * SK ITCBundle XML Schema GroupEntity Field
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\XMLSchema\Entity;

use SK\ITCBundle\XMLSchema\Entity;

class GroupEntity extends Entity
{

	/**
	 * SK ITCBundle XML Schema Entity GroupEntity Name
	 *
	 * @var string
	 */
	protected $elementTagName = 'group';

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
}