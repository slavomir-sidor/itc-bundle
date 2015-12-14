<?php

/**
 * SK ITCBundle Generator XML Schema Service
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Code\Generator\XMLSchema;

class View extends AbstractGenerator
{
	
	/**
	 * (non-PHPdoc)
	 *
	 * @see \Zend\Code\Generator\GeneratorInterface::generate()
	 */
	public function generate( $xsd )
	{
		$xsd = $this->getDocument( $xsd );
		$xsdSchema = $xsd->getSchema();
		
		$xsdSchemaAnnotations = $xsdSchema->getAnnotation();
		foreach( $xsdSchemaAnnotations as $xsdSchemaAnnotations )
		{
		}
		
		$xsdSchemaGroups = $xsdSchema->getGroup();
		foreach( $xsdSchemaGroups as $xsdSchemaGroups )
		{
		}
		
		$xsdSchemaSimpleTypes = $xsdSchema->getSimpleType();
		foreach( $xsdSchemaSimpleTypes as $xsdSchemaSimpleTypes )
		{
		}
		$xsdSchemaComplexTypes = $xsdSchema->getComplexType();
		foreach( $xsdSchemaComplexTypes as $xsdSchemaComplexTypes )
		{
		}
	}
}