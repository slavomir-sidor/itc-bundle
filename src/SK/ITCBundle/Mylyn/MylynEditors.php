<?php
/**
 * SK ITC Bundle Mylyn Editors
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 *
 */
namespace SK\ITCBundle\Mylyn;

use JMS\Serializer\Annotation\Type;
use JMS\Serializer\Annotation\SerializedName;
use JMS\Serializer\Annotation\XmlAttribute;

class MylynEditors
{

	/**
	 * @Type("SK\ITCBundle\Mylyn\MonitoredWindowOpenEditors")
	 * @SerializedName("MonitoredWindowOpenEditors")
	 *
	 * @var MonitoredWindowOpenEditors
	 */
	protected $monitoredWindowOpenEditors;

	/**
	 * @XmlAttribute
     * @Type("string")
     */
	protected $class;

	/**
	 * @XmlAttribute
	 * @Type("boolean")
	 */
	protected $isActive;

	/**
	 * @XmlAttribute
	 * @Type("boolean")
	 */
	protected $isLaunching;

	/**
	 * @XmlAttribute
	 * @Type("integer")
	 */
	protected $number;
}