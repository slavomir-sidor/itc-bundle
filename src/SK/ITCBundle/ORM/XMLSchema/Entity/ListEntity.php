<?php

/**
 * SK ITCBundle XML Schema Entity List
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\ORM\XMLSchema\Entity;

use SK\ITCBundle\ORM\XMLSchema\Entity;

class ListEntity extends Entity
{

	/**
	 * SK ITCBundle XML Schema Entity List Name
	 *
	 * @var string
	 */
	protected $elementTagName = 'list';

	/**
	 *
	 * @var WhiteSpaceAttrsEntity[]
	 */
	protected $whiteSpaceAttrs;

}