<?php

/**
 * SK ITCBundle Command Code Abstract Generator
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator;

use SK\ITCBundle\Command\Code\CodeCommand;

abstract class GeneratorCommand extends CodeCommand
{

	/**
	 * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Destination directory
	 *
	 * @var string
	 */
	protected $dest;

	/**
	 * Constructs SK ITCBundle Command Code Abstract Generator
	 *
	 * @param string $name
	 *        	SK ITCBundle Command Code Abstract Generator Name
	 * @param string $description
	 *        	SK ITCBundle Command Code Abstract Generator Description
	 */
	public function __construct( 
		$name, 
		$description )
	{

		parent::__construct( $name, $description );
	
	}

	/**
	 *
	 * @return string
	 */
	public function getDest()
	{

		if( NULL == $this->dest )
		{
			$this->setDest( $this->getRootDir() . DIRECTORY_SEPARATOR . "tests" );
		}
		
		if( ! file_exists( $this->dest ) )
		{
			@mkdir( $this->dest, 0777, true );
		}
		
		return $this->dest;
	
	}

	/**
	 *
	 * @param string $dest        	
	 */
	public function setDest( 
		$dest )
	{

		if( NULL == $this->dest )
		{
			$this->dest = $this->getRootDir() . DIRECTORY_SEPARATOR . $dest;
		}
		
		if( ! file_exists( $this->dest ) )
		{
			mkdir( $this->dest, 0777, true );
		}
		
		return $this;
	
	}

}