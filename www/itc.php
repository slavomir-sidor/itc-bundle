<?php
/**
 * SK ITCBundle Web Application
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */

use Symfony\Component\HttpFoundation\Request;
use SK\ITCBundle\Application\RESTKernel;

/**
 * @var Composer\Autoload\ClassLoader $loader
 */

/**
 * @var Composer\Autoload\ClassLoader
 */
$loader = require __DIR__.'/../vendor/autoload.php';

// Enable APC for autoloading to improve performance.
// You should change the ApcClassLoader first argument to a unique prefix
// in order to prevent cache key conflicts with other applications
// also using APC.
/*
$apcLoader = new Symfony\Component\ClassLoader\ApcClassLoader(sha1(__FILE__), $loader);
$loader->unregister();
$apcLoader->register(true);
*/
//require_once __DIR__.'/../app/AppCache.php';
$environment=isset($_SERVER['envi'])?$_SERVER['envi']:'dev';
$kernel = new RESTKernel('dev', false);
$kernel->loadClassCache();
//$kernel = new AppCache($kernel);

// When using the HttpCache, you need to call the method in your front controller instead of relying on the configuration parameter
Request::enableHttpMethodParameterOverride();
$request = Request::createFromGlobals();
$response = $kernel->handle($request);
$response->send();
$kernel->terminate($request, $response);