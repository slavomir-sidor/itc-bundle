<?php
/**
 * SK ITC Bundle Mylyn Input
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 *
 */
namespace SK\ITCBundle\Mylyn;

use JMS\Serializer\Annotation\Type;
use JMS\Serializer\Annotation\SerializedName;
use JMS\Serializer\Annotation\XmlAttribute;

class Input
{

	/**
	 * @XmlAttribute
	 * @Type("integer")
	 */
	protected $factoryID;

	/**
	 * @XmlAttribute
	 * @Type("string")
	 */
	protected $taskHandle;
}