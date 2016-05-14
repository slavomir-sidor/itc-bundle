#!/usr/bin/env php

<?php

/**
 * SK ITCBundle Console Application
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */

/**
 * SK ITCBundle Console Application Loader
 *
 * @var Composer\Autoload\ClassLoader $loader
 */
$loader = require __DIR__ . '/../vendor/autoload.php';

/**
 * SK ITCBundle Console Application Doctrine Annotation
 *
 * @var \Doctrine\Common\Annotations\AnnotationRegistry
 */
\Doctrine\Common\Annotations\AnnotationRegistry::registerLoader( array(
	$loader,
	'loadClass'
) );

/**
 * SK ITCBundle Console Application Debugging
 *
 * @var string
 */
$debug = getenv( 'SYMFONY_DEBUG' ) !== '0' && ! $input->hasParameterOption( array(
	'--no-debug',
	''
) ) && $env !== 'prod';

if( $debug )
{
	\Symfony\Component\Debug\Debug::enable();
}

/**
 * SK ITCBundle Console Application Run
 */
( new \SK\ITCBundle\Application\Socket() )->run();