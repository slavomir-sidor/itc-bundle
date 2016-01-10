<?php
/**
 * SK ITCBundle Code Generator Collection AttributesCollection
 */


namespace SK\ITCBundle\Code\Generator\Collection;


use TokenReflection\Php\ReflectionProperty;
use SK\ITCBundle\Code\Reflection\Collection\AttributesCollection as ReflectionAttributesCollection;

class AttributesCollection extends SK\ITCBundle\Code\Reflection\Collection\AttributesCollection
{

    /**
     * @var ReflectionProperty[]
     */
    protected $elements = null;

    /**
     * @var array $columns
     */
    protected $columns = array(
        'Accessibility',
        'Static',
        'Class',
        'Attribute',
        'Type',
        'Default',
    );

    /**
     * @return array
     */
    public function toArray()
    {
        $rows = [];

        /* @var $reflection ReflectionProperty */
        foreach( $this->getIterator() as $reflection )
        {
        	$row = [];

        	$row['Accessibility'] = self::getAccessibility( $reflection );
        	$row['Static'] = self::getStatic( $reflection );
        	$row['Class'] = $reflection->getDeclaringClassName();
        	$row['Attribute'] = $reflection->getName();
        	$row['Type'] = self::getAttributeType( $reflection );
        	$row['Default'] = self::getAttributeDefault( $reflection );

        	$rows[] = $row;
        }

        return $rows;
    }


}

