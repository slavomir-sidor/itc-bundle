<?php

/**
 * SK ITCBundle XML Schema Entity ImportEntity
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\XMLSchema\Entity;

use SK\ITCBundle\XMLSchema\Entity;

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