#!/usr/bin/env php

<?php
/**
 * SK ITCBundle Fast Process Management
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */

/**
 * @var Composer\Autoload\ClassLoader $loader
 */
$loader = require __DIR__.'/../vendor/autoload.php';

$input = new \Symfony\Component\Console\Input\ArgvInput();
$env = $input->getParameterOption(array('--env', '-e'), getenv('SYMFONY_ENV') ?: 'dev');
$debug = getenv('SYMFONY_DEBUG') !== '0' && !$input->hasParameterOption(array('--no-debug', '')) && $env !== 'prod';

if ($debug) {
    \Symfony\Component\Debug\Debug::enable();
}

(new \SK\ITCBundle\Application\Console(
    new \SK\ITCBundle\Application\ConsoleKernel($env, $debug)
))->run ();