<?php
/**
 * SK ITC Bundle DTD Annotation
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\DTD;

class Annotation
{

	/**
	 * SK ITC Bundle DTD Annotation Content
	 *
	 * @var string
	 */
	protected $content;

	/**
	 * Constructs SK ITC Bundle DTD Annotation Content
	 *
	 * @param string $content
	 *        	SK ITC Bundle DTD Annotation Content
	 */
	public function __construct($content = "")
	{
		$this->setContent($content);
	}

	/**
	 * Creates SK ITC Bundle DTD Annotation
	 *
	 * @param string $content
	 *        	SK ITC Bundle DTD Annotation Content
	 * @return \SK\ITCBundle\DTD\Annotation
	 */
	public static function create($content)
	{
		return new self($content);
	}

	/**
	 * Gets SK ITC Bundle DTD Annotation Content
	 *
	 * @return string
	 */
	public function getContent()
	{
		return $this->content;
	}

	/**
	 * Sets SK ITC Bundle DTD Annotation Content
	 *
	 * @param string $content        	
	 * @return \SK\ITCBundle\DTD\Annotation
	 */
	public function setContent($content)
	{
		$this->content = trim($content);
		return $this;
	}
}