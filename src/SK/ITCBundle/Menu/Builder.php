<?php

/**
 * SK ITCBundle Menu Builder
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Menu;

use Knp\Menu\FactoryInterface;
use Symfony\Component\HttpFoundation\RequestStack;
use Symfony\Component\Intl\Data\Util\RecursiveArrayAccess;

class Builder
{
	
	/**
	 * SK ITCBundle Menu Builder Factory Interface
	 *
	 * @var FactoryInterface
	 */
	protected $factory;
	protected $config;
	
	/**
	 * Constructs SK ITCBundle Menu Builder
	 *
	 * @param FactoryInterface $factory
	 *        	SK ITCBundle Menu Builder Factory Interface
	 */
	public function __construct( FactoryInterface $factory )
	{
		$this->setFactory( $factory );
	}
	
	/**
	 * Creates SK ITCBundle Menu Builder Menu Item Interface
	 *
	 * @param RequestStack $requestStack
	 *        	SK ITCBundle Menu Builder Request Stack
	 * @return \Knp\Menu\ItemInterface
	 */
	public function createMenu( RequestStack $requestStack, $configItems, $parent = null )
	{
		if( NULL === $parent )
		{
			$factory = $this->getFactory();
			$parent = $factory->createItem( 'root' );
		}
		
		foreach( $configItems as $configItem )
		{
			$name = $configItem[ 'label' ];
			$options = $configItem[ 'options' ];
			$item = $parent->addChild( $name, $options );
			if( array_key_exists( 'items', $configItem ) && count( $configItem[ 'items' ] ) > 0 )
			{
				$this->createMenu( $requestStack, $configItem[ 'items' ], $item );
			}
		}
		
		return $parent;
	}
	protected function createMainItem( $menu, $config )
	{
		$factory = $this->getFactory();
	}
	
	/**
	 * Gets SK ITCBundle Menu Builder Factory Interface
	 *
	 * @return FactoryInterface
	 */
	public function getFactory()
	{
		return $this->factory;
	}
	
	/**
	 * Sets SK ITCBundle Menu Builder Factory Interface
	 *
	 * @param FactoryInterface $factory
	 *        	SK ITCBundle Menu Builder Factory Interface
	 * @return \SK\ITCBundle\Menu\Builder Return SK ITCBundle Menu Builder
	 */
	public function setFactory( FactoryInterface $factory )
	{
		$this->factory = $factory;
		return $this;
	}
}