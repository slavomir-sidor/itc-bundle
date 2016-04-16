<?php

/**
 * SK ITCBundle XML Schema Entity ImportEntity
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\ORM\XMLSchema\Entity;

use SK\ITCBundle\ORM\XMLSchema\Entity;

class ImportEntity extends Entity
{

	/**
	 * SK ITCBundle XML Schema Entity ImportEntity Name
	 *
	 * @var string
	 */
	protected $elementTagName = 'import';

	/**
	 *
	 * @var AnnotationEntity[]
	 */
	protected $annotation;

}