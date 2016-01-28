<?php
/**
 * SK ITC Bundle Mylyn Context State
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Mylyn;

use JMS\Serializer\Annotation\XmlRoot as XmlRoot;
use JMS\Serializer\Annotation\XmlAttribute;
use JMS\Serializer\Annotation\XmlValue;

/** @XmlRoot("ContextState") */
class ContextState
{
	/**
	 *
	 * @var string $taskID
	 */
	protected $taskID;

	/**
	 *
	 * @var string $status
	 */
	protected $status;

	/**
	 *
	 * @var string $title
	 */
	protected $title;

	/**
	 *
	 * @var string $hours
	 */
	protected $hours;

	/**
	 *
	 * @var string $modified
	 */
	protected $modified;

	/**
	 *
	 * @return string
	 */
	public function getTaskID()
	{
		return $this->taskID;
	}

	/**
	 *
	 * @param string $taskID
	 */
	public function setTaskID( $taskID )
	{
		$this->taskID = $taskID;
		return $this;
	}

	/**
	 *
	 * @return string
	 */
	public function getStatus()
	{
		return $this->status;
	}

	/**
	 *
	 * @param string $status
	 */
	public function setStatus( $status )
	{
		$this->status = $status;
		return $this;
	}

	/**
	 *
	 * @return string
	 */
	public function getTitle()
	{
		return $this->title;
	}

	/**
	 *
	 * @param
	 *        	string string $title
	 */
	public function setTitle( $title )
	{
		$this->title = $title;
		return $this;
	}

	/**
	 *
	 * @return string
	 */
	public function getHours()
	{
		return $this->hours;
	}

	/**
	 *
	 * @param string $hours
	 */
	public function setHours( $hours )
	{
		$this->hours = $hours;
		return $this;
	}

	/**
	 *
	 * @return string
	 */
	public function getModified()
	{
		return $this->modified;
	}

	/**
	 *
	 * @param string $modified
	 */
	public function setModified( $modified )
	{
		$this->modified = $modified;
		return $this;
	}

	public function toArray()
	{
		return get_object_vars($this);
	}
}