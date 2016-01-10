<?php
/**
 * SK ITCBundle Code Generator Collection OperationCollection
 */


namespace SK\ITCBundle\Code\Generator\Collection;


use TokenReflection\Php\ReflectionMethod;
use SK\ITCBundle\Code\Reflection\Collection\OperationCollection as ReflectionOperationCollection;

class OperationCollection extends SK\ITCBundle\Code\Reflection\Collection\OperationCollection
{

    /**
     * @var ReflectionMethod[]
     */
    protected $elements = null;

    /**
     * @var array
     */
    protected $columns = array(
        'Class',
        'Accessibility',
        'Abstract',
        'Static',
        'Operation',
        'Parameters',
        'Returns',
    );

    /**
     * @return array
     */
    public function toArray()
    {
        $rows = [];

        /* @var $reflection ReflectionMethod */
        foreach( $this->getIterator() as $reflection )
        {
        	$row = [];

        	$row['Class'] = $reflection->getDeclaringClassName();
        	$row['Accessibility'] = self::getAccessibility( $reflection );
        	$row['Abstract'] = self::getAbstract( $reflection );
        	$row['Static'] = self::getStatic( $reflection );
        	$row['Operation'] = $reflection->getName();
        	$row['Parameters'] = self::getOperationParameters($reflection);
        	$row['Returns'] = self::getOperationReturns($reflection);

        	$rows[] = $row;
        }
        return $rows;
    }


}

