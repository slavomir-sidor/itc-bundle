<?php
/**
 * SK ITCBundle Code Generator Collection ParameterCollection
 */


namespace SK\ITCBundle\Code\Generator\Collection;


use SK\ITCBundle\Code\Reflection\Collection\ParameterCollection as ReflectionParameterCollection;
use TokenReflection\Php\ReflectionParameter;

class ParameterCollection extends SK\ITCBundle\Code\Reflection\Collection\ParameterCollection
{

    /**
     * @var ReflectionParameter[]
     */
    protected $elements = null;

    /**
     * @var array $columns
     */
    protected $columns = array(
        'Class Name',
        'Operation',
        'Parameter',
        'Type',
        'Default',
    );

    /**
     * @return array
     */
    public function toArray()
    {
        $rows = [];

        /* @var $reflection  ReflectionParameter */
        foreach( $this->getIterator() as $reflection )
        {
        	$row = [];

        	$row['Class'] = $reflection->getDeclaringClassName();
        	$row['Operation'] = $reflection->getDeclaringFunctionName();
        	$row['Parameter'] = $reflection->getName();
        	$row[ 'Type' ] =self::getParameterType($reflection);
        	//$reflection->getOriginalTypeHint();
        	$row[ 'Default' ] = is_array( $reflection->getDefaultValue() ) ? 'array' : $reflection->getDefaultValue();

        	$rows[] = $row;
        }

        return $rows;
    }


}

