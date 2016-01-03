<?php
namespace SK\ITCBundle\Code\Reflection;

use TokenReflection\Php\IReflection;

trait Helper
{

	/**
	 *
	 * @param IReflection $reflection
	 * @return string
	 */
	protected static function getAccessibility( $reflection )
	{
		return $reflection->isPrivate() ? "Private" : ( $reflection->isProtected() ? "Protected" : "Public" );
	}

	/**
	 *
	 * @param IReflection $reflection
	 * @return string
	 */
	protected static function getStatic( $reflection )
	{
		return $reflection->isStatic() ? "Yes" : "No";
	}

	/**
	 *
	 * @param IReflection $reflection
	 * @return string
	 */
	protected static function getAbstract( $reflection )
	{
		return $reflection->isAbstract() ? "Yes" : "No";
	}

	/**
	 *
	 * @param IReflection $reflection
	 * @return string
	 */
	protected static function getObjectType( $reflection )
	{
		return $reflection->isTrait() ? "Trait" : ( $reflection->isInterface() ? "Interface" : "Class" );
	}
}