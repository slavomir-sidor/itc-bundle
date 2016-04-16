<?php
/**
 * SK ITC Bundle Mylyn Editor
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 *
 */
namespace SK\ITCBundle\Service\Mylyn;

use JMS\Serializer\Annotation\Type;
use JMS\Serializer\Annotation\SerializedName;
use JMS\Serializer\Annotation\XmlAttribute;

class Editor
{

	/**
	 * @Type("SK\ITCBundle\Service\Mylyn\Input")
	 * @SerializedName("input")
	 *
	 * @var Input
	 */
	protected $input;

	/**
	 * @XmlAttribute
	 * @Type("integer")
	 */
	protected $id;

	/**
	 * @XmlAttribute
	 * @Type("string")
	 */
	protected $name;

	/**
	 * @XmlAttribute
	 * @Type("string")
	 */
	protected $partName;

	/**
	 * @XmlAttribute
	 * @Type("string")
	 */
	protected $title;

	/**
	 * @XmlAttribute
	 * @Type("string")
	 */
	protected $tooltip;
}