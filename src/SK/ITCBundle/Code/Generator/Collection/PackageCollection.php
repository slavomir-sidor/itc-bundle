<?php
/**
 * SK ITCBundle Code Generator Collection PackageCollection
 */


namespace SK\ITCBundle\Code\Generator\Collection;


use TokenReflection\ReflectionNamespace;
use SK\ITCBundle\Code\Reflection\Collection\PackageCollection as ReflectionPackageCollection;

class PackageCollection extends SK\ITCBundle\Code\Reflection\Collection\PackageCollection
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

