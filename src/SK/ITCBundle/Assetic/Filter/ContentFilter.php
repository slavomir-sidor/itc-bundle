<?php
/**
 * SK ITCBundle Assetic Filter Content Filter
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Assetic\Filter;

use Assetic\Asset\AssetInterface;
use Assetic\Filter\FilterInterface;

class ContentFilter implements FilterInterface
{

	public function filterLoad(AssetInterface $asset)
	{}

	public function filterDump(AssetInterface $asset)
	{
		$content = $asset->getContent();
		var_dump($content);
		// Do something to $content
		$asset->setContent($content);
	}
}