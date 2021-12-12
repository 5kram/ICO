// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
 * @title Queue
 * @dev Data structure contract used in `Crowdsale.sol`
 * Allows buyers to line up on a first-in-first-out basis
 * Is deployed by `Crawdsale.sol`
 */

contract Queue
{
	/// State variables
	uint8 size = 5;
	uint256 timeLimit = 5 minutes;
	/// When the queue isLIFO the first buyer is at index 0,
	/// in order to push the next buyer in the next empty position.
	/// When the queue !isLIFO the first buyer is last in line,
	/// in order to pop the first buyer from the queue.
	bool isLIFO;
	
	struct User
	{
		address who;
		uint256 timestamp;
		bool hasFinished;
	}

	User[] public users;
	
	/// Add events
	event TimeOut(address indexed _who);


	constructor()
	{
		isLIFO = true;
	}
	
	/// Called when the order isLIFO, from buy function in Crawdsale
	function finished()
	public
	{
		users[0].hasFinished = true;
	}
	
	/// Returns the number of people waiting in line
	function qsize()
	public view
	returns(uint8)
	{
		return uint8(users.length);
	}

	/// Returns whether the queue is empty or not
	function empty()
	public view
	returns(bool)
	{
		return (users.length == 0);
	}
	
	/// Returns the address of the person in the front of the queue
	function getFirst()
	public
	returns(address)
	{
		if (!isLIFO)
		{
			swapOrder();
			isLIFO = true;
		}
		return users[0].who;
	}
	
	/// Allows `msg.sender` to check their position in the queue
	function checkPlace()
	public view
	returns(uint8)
	{
		for (uint8 i = 0; i < users.length - 1; i++)
		{
			if (users[i].who == tx.origin)
			{
				return i + 1;
			}
		}
		return 0;
	}
	
	/* Allows anyone to expel the first person in line if their time
	 * limit is up
	 */
	function checkTime()
	public
	{	
		if (isLIFO)
		{
			swapOrder();
			isLIFO = false;
		}
		require(users[users.length - 1].timestamp + timeLimit >= block.timestamp);
		users[users.length - 1].hasFinished = true;
		emit TimeOut(users[users.length - 1].who);
		dequeue();
	}
	
	/* Removes the first person in line; either when their time is up or when
	 * they are done with their purchase
	 */
	function dequeue()
	public
	{
		if (isLIFO)
		{
			swapOrder();
			isLIFO = false;
		}
		require(users[users.length - 1].hasFinished, "Stop Pushing.");
		users.pop();
	}

	/// Places `addr` in the first empty position in the queue
	function enqueue(address addr)
	public
	{
		if (!isLIFO)
		{
			swapOrder();
			isLIFO = true;
		}
		User memory user;
		user.who = addr;
		user.timestamp = block.timestamp;
		user.hasFinished = false;
		users.push(user);
	}

	function swapOrder()
	public
	{
		uint256 length = users.length;
		for (uint8 i = 0; i < (length) / 2; i++)
		{	
			User memory TempUser;
			TempUser = users[i];
			users[i] = users[length - 1 - i];
			users[length - 1 - i] = TempUser;
		}
	}
}
