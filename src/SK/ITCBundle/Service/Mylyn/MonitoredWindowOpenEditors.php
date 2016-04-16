<?php
/**
 * SK ITC Bundle Mylyn Editors
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 *
 */
namespace SK\ITCBundle\Service\Mylyn;

use JMS\Serializer\Annotation\Type;
use JMS\Serializer\Annotation\SerializedName;
use JMS\Serializer\Annotation\XmlAttribute;

class MonitoredWindowOpenEditors
{

	/**
	 * @Type("SK\ITCBundle\Service\Mylyn\Editor")
	 * @SerializedName("editor")
	 *
	 * @var Editor
	 */
	protected $editor;
}