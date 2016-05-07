<?php

/**
 * SK ITC Bundle Application Socket
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 *
 */
namespace SK\ITCBundle\Application;

use Ratchet\MessageComponentInterface;
use Ratchet\ConnectionInterface;

class Socket implements MessageComponentInterface
{

	/**
	 * SK ITC Bundle Application Socket Socket Clients
	 *
	 * @var \SplObjectStorage $clients
	 */
	protected $clients;

	/**
	 * Constructs SK ITC Bundle Application Socket Socket Clients
	 */
	public function __construct()
	{
		$this->clients = new \SplObjectStorage();
	}

	/**
	 * SK ITC Bundle Application Socket Socket On Open
	 *
	 * @param ConnectionInterface $conn
	 */
	public function onOpen( ConnectionInterface $conn )
	{
		// Store the new connection to send messages to later
		$this->clients->attach( $conn );
		echo "New connection! ({$conn->resourceId})\n";
	}

	/**
	 * SK ITC Bundle Application Socket Socket On Message
	 *
	 * @param ConnectionInterface $from
	 * @param unknown $msg
	 */
	public function onMessage( ConnectionInterface $from, $msg )
	{
		$numRecv = count( $this->clients ) - 1;
		echo sprintf( 'Connection %d sending message "%s" to %d other connection %s' . "\n",
			$from->resourceId,
			$msg,
			$numRecv,
			$numRecv == 1 ? '' : 's' );

		foreach( $this->clients as $client )
		{
			if( $from !== $client )
			{
				// The sender is not the receiver, send to each client connected
				$client->send( $msg );
			}
		}
	}

	/**
	 * SK ITC Bundle Application Socket Socket On Close
	 *
	 * @param ConnectionInterface $conn
	 */
	public function onClose( ConnectionInterface $conn )
	{
		// The connection is closed, remove it, as we can no longer send it messages
		$this->clients->detach( $conn );
		echo "Connection {$conn->resourceId} has disconnected\n";
	}

	/**
	 * SK ITC Bundle Application Socket Socket On Error
	 *
	 * @param ConnectionInterface $conn
	 * @param \Exception $e
	 */
	public function onError( ConnectionInterface $conn, \Exception $e )
	{
		echo "An error has occurred: {$e->getMessage()}\n";

		$conn->close();
	}
}
