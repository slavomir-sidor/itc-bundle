<?php

/**
 * SK ITCBundle XML Schema Entity SequenceEntity
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\XMLSchema\Entity;

use SK\ITCBundle\XMLSchema\Entity;
use Doctrine\DBAL\Schema\Sequence;

class SequenceEntity extends Entity
{
	
	/**
	 * SK ITCBundle XML Schema Entity SequenceEntity Name
	 *
	 * @var string
	 */
	protected $elementTagName = 'sequence';
	
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
	protected $cs;
	
	/**
	 *
	 * @var SequenceEntity[]
	 */
	protected $sequence;
	
	/**
	 *
	 * @var AnyEntity[]
	 */
	protected $any;
	
	/**
	 *
	 * @var ChoiceEntity[]
	 */
	protected $choice;
}