<?php
/**
 * SK ITC Bundle ODM Document
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Document;

abstract class Document extends \SplFileObject
{

	/**
	 * SK ITC Bundle Document Source
	 *
	 * @var Source
	 */
	protected $source;
}