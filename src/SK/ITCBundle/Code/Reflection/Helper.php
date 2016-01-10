<?php
/**
 * SK ITCBundle Code Reflection Helper
 */


namespace SK\ITCBundle\Code\Reflection;


use TokenReflection\IReflection;
use TokenReflection\ReflectionClass;
use TokenReflection\ReflectionParameter;
use TokenReflection\ReflectionProperty;
use TokenReflection\Php\ReflectionMethod;

abstract class Helper
{

    /**
     * @param IReflection $reflection
     * @return string
     */
    protected static function getAccessibility(\TokenReflection\IReflection $reflection)
    {
        return $reflection->isPrivate() ? "Private" : ( $reflection->isProtected() ? "Protected" : "Public" );
    }

    /**
     * @param IReflection $reflection
     * @return string
     */
    protected static function getStatic(\TokenReflection\IReflection $reflection)
    {
        return $reflection->isStatic() ? "Yes" : "No";
    }

    /**
     * @param IReflection $reflection
     * @return string
     */
    protected static function getAbstract(\TokenReflection\IReflection $reflection)
    {
        return $reflection->isAbstract() ? "Yes" : "No";
    }

    /**
     * @param ReflectionClass $reflection
     * @return string
     */
    protected static function getParents(\TokenReflection\ReflectionClass $reflection)
    {
        return implode( "\n", $reflection->getParentClassNameList() );
    }

    /**
     * @param ReflectionClass $reflection
     * @return string
     */
    protected static function getInterfaces(\TokenReflection\ReflectionClass $reflection)
    {
        return implode( "\n", $reflection->getInterfaceNames() );
    }

    /**
     * @param ReflectionClass $reflection
     * @return string
     */
    protected static function getFinal(\TokenReflection\ReflectionClass $reflection)
    {
        return $reflection->isFinal() ? "Yes" : "No";
    }

    /**
     * @param ReflectionClass $reflection
     * @return string
     */
    protected static function getObjectType(\TokenReflection\ReflectionClass $reflection)
    {
        return $reflection->isTrait() ? "Trait" : ( $reflection->isInterface() ? "Interface" : "Class" );
    }

    /**
     * @param ReflectionProperty $reflection
     * @return string
     */
    protected static function getAttributeType(\TokenReflection\ReflectionProperty $reflection)
    {
        $var=$reflection->getAnnotation( "var" );
        return implode( ",", array_values( is_array( $var ) ? $var : [] ) );
    }

    /**
     * @param ReflectionProperty $reflection
     * @return string
     */
    protected static function getAttributeDefault(\TokenReflection\ReflectionProperty $reflection)
    {
        return is_array( $reflection->getDefaultValue() ) ? 'array' : $reflection->getDefaultValue();
    }

    /**
     * @param IReflection $reflection
     * @return string
     */
    protected static function getOperationParameters(\TokenReflection\IReflection $reflection)
    {
        $parameters = $reflection->getParameters();
        $operationsParameters = [];

        foreach( $parameters as $parameter )
        {
        	$operationsParameters[] = $parameter->getName();
        }

        return implode( ', ', $operationsParameters );
    }

    /**
     * @param ReflectionMethod $reflection
     * @return string
     */
    protected static function getOperationReturns(\TokenReflection\IReflection $reflection)
    {
        $return=$reflection->getAnnotation( "return" );
        return implode( ",", array_values( is_array( $return ) ? $return : [] ) );
    }

    /**
     * @param ReflectionParameter $reflection
     * @return string
     */
    protected static function getParameterType(\TokenReflection\ReflectionParameter $reflection)
    {
        $operationReflection=$reflection->getDeclaringFunction();

        return implode( ",", array_values( is_array( $return ) ? $return : [] ) );
    }

    /**
     * @param ReflectionParameter $reflection
     * @return string
     */
    protected static function getParameterDefaultValue(\TokenReflection\ReflectionParameter $reflection)
    {
        return $reflection->isOptional()?$reflection->getDefaultValue():'';
    }


}

