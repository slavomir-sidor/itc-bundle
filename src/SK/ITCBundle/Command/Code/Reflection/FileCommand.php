<?php

/**
 * SK ITCBundle Command Code Reflection Files
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Reflection;

use Zend\Code\Reflection\FileReflection;

class FileCommand extends ReflectionCommand
{

	protected $columns = array(
		"Files",
		"Owner",
		"Group",
		"Permissions",
		"Created",
		"Modified"
	);

	protected function getRows()
	{
		if( null === $this->rows )
		{
			$reflections = $this->getReflection()->getFiles();

			$rows = [];
			$currentDir=getcwd().DIRECTORY_SEPARATOR;

			/* @var $reflection FileReflection  */
			foreach( $reflections as $reflection )
			{
				$row = [];

				$file = new \SplFileInfo($reflection->getName());

				$row = array(
					"Files" => str_replace($currentDir,"",$file->getPathName()),
					"Owner" => $file->getOwner(),
					"Group" => $file->getGroup(),
					"Permissions" => $file->getPerms(),
					"Created" => date("d.m.Y h:m:s", $file->getCTime()),
					"Modified" => date("d.m.Y h:m:s", $file->getMTime())
				);

				$rows[] = $row;
			}

			$this->setRows($rows);
		}

		return $this->rows;
	}
}