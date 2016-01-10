<?php
/**
 * SK ITCBundle Code Generator Collection FileCollection
 */


namespace SK\ITCBundle\Code\Generator\Collection;


use SK\ITCBundle\Code\Reflection\Collection\FileCollection as ReflectionFileCollection;
use Zend\Code\Generator\FileGenerator;

class FileCollection extends SK\ITCBundle\Code\Reflection\Collection\FileCollection
{

    /**
     * @var FileGenerator[]
     */
    protected $elements = null;

    /**
     * @var array
     */
    protected $columns = array(
        'Files',
        'Short Description',
    );

    /**
     * @return array
     */
    public function toArray()
    {
        $rows = [];
        $currentDir = getcwd() . DIRECTORY_SEPARATOR;

        /* @var $item FileGenerator  */
        foreach( $this->getIterator() as $name=>$item )
        {
        	$row = [];

        	$file = new \SplFileInfo( $name );

        	$row = array(
        		"Files" => str_replace( $currentDir, "", $file->getPathName() ),
        		"ShortDescription" => $item->getDocBlock()->getShortDescription()
        	);

        	$rows[] = $row;
        }

        return $rows;
    }


}

