<?php
/**
 * SK ITCBundle XML Schema Entity AnnotationEntity
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\XMLSchema\Entity;

use SK\ITCBundle\XMLSchema\Entity;

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