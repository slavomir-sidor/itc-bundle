<?php
/**
 * SK ITCBundle Code Reflection Collection PackageCollection
 */


namespace SK\ITCBundle\Code\Reflection\Collection;


use SK\ITCBundle\Code\Collection;
use TokenReflection\ReflectionNamespace;

class PackageCollection extends SK\ITCBundle\Code\Collection
{

    /**
     * @var ReflectionNamespace[]
     */
    protected $elements = null;

    /**
     * @var array $columns
     */
    protected $columns = array(
        'Namespace',
    );

    /**
     * @return array
     */
    public function toArray()
    {
        $rows = [];

        /* @var $package ReflectionNamespace */
        foreach( $this->getIterator() as $package )
        {
        	$row = [];
        	$row['Namespace'] = $package->getName();
        	$rows[] = $row;
        }

        return $rows;
    }


}

