<?php

/**
 * SK ITCBundle XML Schema Entity ElementEntity
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\ORM\XMLSchema\Entity;

use SK\ITCBundle\ORM\XMLSchema\Entity;

class ElementEntity extends Entity
{

	/**
	 * SK ITCBundle XML Schema Entity Entity Name
	 *
	 * @var string
	 */
	protected $elementTagName = 'element';

	/**
	 *
	 * @var AnnotationEntity[]
	 */
	protected $annotation;

	/**
	 *
	 * @var ComplexTypeEntity[]
	 */
	protected $complexType;

	/**
	 *
	 * @var KeyEntity[]
	 */
	protected $key;

}