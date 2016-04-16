<?php

/**
 * SK ITC Bundle DTD Entity External Public
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\DTD\Entity;

use SK\ITCBundle\DTD\Entity;

class ExternalPublic extends Entity
{

	/**
	 * SK ITC Bundle DTD Entity External Public Identifier
	 *
	 * @var string
	 */
	protected $identifier;

	/**
	 * SK ITC Bundle DTD Entity External Public Uri
	 *
	 * @var string
	 */
	protected $uri;

	/**
	 * Gets SK ITC Bundle DTD Entity External Public Identifier
	 *
	 * @return the string
	 */
	public function getIdentifier()
	{

		return $this->identifier;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Entity External Public Identifier
	 *
	 * @param string $identifier
	 *        	SK ITC Bundle DTD Entity External Public Identifier
	 * @return \SK\ITCBundle\DTD\Entity\ExternalPublic
	 */
	public function setIdentifier( 
		$identifier )
	{

		$this->identifier = $identifier;
		return $this;
	
	}

	/**
	 * Gets SK ITC Bundle DTD Entity External Public Uri
	 *
	 * @return the string
	 */
	public function getUri()
	{

		return $this->uri;
	
	}

	/**
	 * Sets SK ITC Bundle DTD Entity External Public Uri
	 *
	 * @param string $uri
	 *        	SK ITC Bundle DTD Entity External Public Uri
	 * @return \SK\ITCBundle\DTD\Entity\ExternalPublic
	 */
	public function setUri( 
		$uri )
	{

		$this->uri = $uri;
		return $this;
	
	}

}