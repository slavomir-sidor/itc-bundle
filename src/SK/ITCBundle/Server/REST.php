<?php
namespace SK\ITCBundle\Server;

class IoServer
{

	/**
	 *
	 * @param int $count
	 *        	worker process count
	 *        	Run the application by entering the event loop
	 * @throws \RuntimeException If a loop was not previously specified
	 */
	public function run( $count = 1 )
	{
		if( null === $this->loop )
		{
			throw new \RuntimeException( "A React Loop was not provided during instantiation" );
		}

		if( $count <= 1 )
		{
			$this->loop->run();
		}
		else
		{
			$loop = $this->loop;
			$master = new \Jenner\SimpleFork\FixedPool( function () use ($loop )
			{
				$this->loop->run();
			}, $count );
			$master->start();
			$master->keep( true );
			// or just
			// $master = new \React\Multi\Master($this->loop, $count);
			// $master->start();
		}
	}
}