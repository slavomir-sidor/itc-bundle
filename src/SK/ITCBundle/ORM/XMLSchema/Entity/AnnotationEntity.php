<?php

/**
 * SK ITCBundle XML Schema Entity AnnotationEntity
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\ORM\XMLSchema\Entity;

use SK\ITCBundle\ORM\XMLSchema\Entity;

class AnnotationEntity extends Entity
{

	/**
	 * SK ITCBundle XML Schema Entity AnnotationEntity Name
	 *
	 * @var string
	 */
	protected $elementTagName = 'annotation';

	/**
	 *
	 * @var AppinfoEntity[]
	 */
	protected $appinfo;

	/**
	 *
	 * @var DocumentationEntity[]
	 */
	protected $documentation;

}