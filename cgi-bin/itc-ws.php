<?php
/**
 *
 * @var Composer\Autoload\ClassLoader
 */
$loader = require __DIR__ . '/../vendor/autoload.php';

$i = 0;
$app = function ( $request, $response ) use ($i )
{
	$response->writeHead( 200, array(
		'Content-Type' => 'text/plain'
	) );

	$response->end( "Hello World " . get_class( $response ) . "\n" );
	$i ++;
};

$loop = React\EventLoop\Factory::create();
$socket = new React\Socket\Server( $loop );
$http = new React\Http\Server( $socket, $loop );
$http->on( 'request', $app );

echo "Server running at http://127.0.0.1:1337\n";

$socket->listen( 1337 );
$loop->run();