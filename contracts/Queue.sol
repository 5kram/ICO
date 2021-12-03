// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
 * @title Queue
 * @dev Data structure contract used in `Crowdsale.sol`
 * Allows buyers to line up on a first-in-first-out basis
 * See this example: http://interactivepython.org/courselib/static/pythonds/BasicDS/ImplementingaQueueinPython.html
 */

contract Queue {
	/* State variables */
	uint8 size = 5;
	// CODE HERE

	/* Add events */
	// CODE HERE

	/* Add constructor */
	// CODE HERE

	/* Returns the number of people waiting in line */
	function qsize()
	public view
	returns(uint8)
	{
		// CODE HERE
	}

	/* Returns whether the queue is empty or not */
	function empty()
	public view
	returns(bool)
	{
		// CODE HERE
	}
	
	/* Returns the address of the person in the front of the queue */
	function getFirst()
	public view
	returns(address)
	{
		// CODE HERE
	}
	
	/* Allows `msg.sender` to check their position in the queue */
	function checkPlace()
	public view
	returns(uint8)
	{
		// CODE HERE
	}
	
	/* Allows anyone to expel the first person in line if their time
	 * limit is up
	 */
	function checkTime()
	public
	{
		// CODE HERE
	}
	
	/* Removes the first person in line; either when their time is up or when
	 * they are done with their purchase
	 */
	function dequeue()
	public
	{
		// CODE HERE
	}

	/* Places `addr` in the first empty position in the queue */
	function enqueue(address addr)
	public
	{
		// CODE HERE
	}
}
