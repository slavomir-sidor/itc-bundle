<?php
namespace SK\ITCBundle\Code\Reflection;

use TokenReflection\Php\IReflection;
use TokenReflection\Php\ReflectionClass;

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
	 * @param ReflectionClass $reflection
	 * @return string
	 */
	protected static function getParents( $reflection )
	{
		return implode( "\n", $reflection->getParentClassNameList() );
	}

	/**
	 *
	 * @param ReflectionClass $reflection
	 * @return string
	 */
	protected static function getInterfaces( $reflection )
	{
		return implode( "\n", $reflection->getInterfaceNames() );
	}

	/**
	 *
	 * @param IReflection $reflection
	 * @return string
	 */
	protected static function getFinal( $reflection )
	{
		return $reflection->isFinal() ? "Yes" : "No";
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

	/**
	 *
	 * @param IReflection $reflection
	 * @return string
	 */
	protected static function getAttributeType( $reflection )
	{
		return implode( ",", array_values( is_array($reflection->getAnnotation( "var" ))?$reflection->getAnnotation( "var" ):[] ) );
	}
}