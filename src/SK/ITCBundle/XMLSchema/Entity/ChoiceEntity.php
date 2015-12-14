<?php

/**
 * SK ITCBundle XML Schema Entity ChoiceEntity
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\XMLSchema\Entity;

use SK\ITCBundle\XMLSchema\Entity;

class ChoiceEntity extends Entity
{
	
	/**
	 * SK ITCBundle XML Schema Entity ChoiceEntity Name
	 *
	 * @var string
	 */
	protected $elementTagName = 'choice';
	
	/**
	 *
	 * @var AnnotationEntity[]
	 */
	protected $annotation;
	
	/**
	 *
	 * @var ElementEntity[]
	 */
	protected $element;
	
	/**
	 *
	 * @var GroupEntity[]
	 */
	protected $group;
	
	/**
	 *
	 * @var AnyAttributeEntity[]
	 */
	protected $any;
	
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