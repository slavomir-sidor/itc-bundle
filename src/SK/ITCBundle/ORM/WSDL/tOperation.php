<?php

/**
 * SK ITCBundle SOAP WSDL tOperation
 *
 * @licence GNU GPL
 * 
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\WSDL;

class tOperation extends Element
{

	const ELEMENT_NAME = 'wsdl:operation';

	/**
	 * SK ITCBundle SOAP WSDL Operation Input
	 *
	 * @var tInput
	 */
	protected $input;

	/**
	 * SK ITCBundle SOAP WSDL Operation Output
	 *
	 * @var tOutput
	 */
	protected $output;

	/**
	 * SK ITCBundle SOAP WSDL Operation Fault
	 *
	 * @var tFault[]
	 */
	protected $fault;

	/**
	 * SK ITCBundle XML Document Contructor
	 *
	 * @param string $uri        	
	 */
	public function __construct( 
		\DOMElement $element )
	{

		$this->setDOMElement( $element );
		
		foreach( $element->childNodes as $childNode )
		{
			if( $childNode instanceof \DOMElement )
			{
				
				switch( $childNode->tagName )
				{
					case tInput::ELEMENT_NAME:
						$this->setInput( new tInput( $childNode ) );
						break;
					case tOutput::ELEMENT_NAME:
						$this->setOutput( new tOutput( $childNode ) );
						break;
					case tFault::ELEMENT_NAME:
						$this->fault[] = new tFault( $childNode );
						break;
				}
			}
		}
	
	}

	/**
	 * Gets SK ITCBundle SOAP WSDL Operation Input
	 *
	 * @return tInput
	 */
	public function getInput()
	{

		return $this->input;
	
	}

	/**
	 * Sets SK ITCBundle SOAP WSDL Operation Input
	 *
	 * @param tInput $input        	
	 */
	public function setInput( 
		tInput $input )
	{

		$this->input = $input;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle SOAP WSDL Operation Output
	 *
	 * @return tOutput
	 */
	public function getOutput()
	{

		return $this->output;
	
	}

	/**
	 * Sets SK ITCBundle SOAP WSDL Operation Output
	 *
	 * @param tOutput $output        	
	 */
	public function setOutput( 
		tOutput $output )
	{

		$this->output = $output;
		return $this;
	
	}

	/**
	 * Gets SK ITCBundle SOAP WSDL Operation Fault
	 *
	 * @return the tFault
	 */
	public function getFault()
	{

		return $this->fault;
	
	}

	/**
	 * Sets SK ITCBundle SOAP WSDL Operation Fault
	 *
	 * @param tFault $fault        	
	 */
	public function setFault( 
		tFault $fault )
	{

		$this->fault = $fault;
		return $this;
	
	}

}