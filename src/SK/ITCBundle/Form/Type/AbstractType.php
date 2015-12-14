<?php

/**
 * SK ITCBundle Form Type Abstract Type
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Form\Type;

use Symfony\Component\Form\AbstractType as SymfonyAbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class AbstractType extends SymfonyAbstractType
{
	
	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Form\FormTypeInterface::getName()
	 */
	public function getName()
	{
		return __NAMESPACE__ . '-' . __CLASS__;
	}
}