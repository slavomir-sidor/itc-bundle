<?php
/**
 * SK ITCBundle Code Reflection Collection AttributesCollection
 */


namespace SK\ITCBundle\Code\Reflection\Collection;


use SK\ITCBundle\Code\Collection;
use TokenReflection\Php\ReflectionProperty;

class AttributesCollection extends SK\ITCBundle\Code\Collection
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
        	$row['Default'] = self::getAttributeDefault($reflection);

        	$rows[] = $row;
        }

        return $rows;
    }


}

