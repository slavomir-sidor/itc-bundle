<?php
/**
 * SK ITC Bundle Mylyn Context State
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Service\Mylyn;

use JMS\Serializer\Annotation\XmlRoot;
use JMS\Serializer\Annotation\Type;
use JMS\Serializer\Annotation\SerializedName;

/**
 * @XmlRoot("ContextState")
 */
class ContextState
{

	/**
	 * @Type("SK\ITCBundle\Service\Mylyn\MylynEditors")
	 * @SerializedName("org.eclipse.mylyn.context.ui.editors")
	 *
	 * @var MylynEditors
	 */
	protected $mylynEditors;

	/**
	 *
	 */
	public function toArray()
	{

	}
}