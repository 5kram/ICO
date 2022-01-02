// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

/**
 * @title Queue
 * @dev Data structure contract used in `Crowdsale.sol`
 * Allows buyers to line up on a first-in-first-out basis
 * Is deployed by `Crawdsale.sol`
 */

contract Queue
{
	/// State variables
	uint8 size = 6;
	uint256 timeLimit = 5 minutes;
	uint8 head = 0;
	uint8 tail = 0;
	uint8 nOfUsers = 0;
	address contractOwner;
	address[6] queue;
	
	mapping(uint8 => bool) hasFinished;
	mapping(uint8 => uint256) timestamp;
	/*
	struct User
	{
		address who;
		uint256 timestamp;
		bool hasFinished;
	}

	User[] public users;
	*/
	/// Add events
	event TimeOut(address indexed _who);


	constructor()
	{
		contractOwner = msg.sender;
	}

	modifier onlyContractOwner()
	{
		require(msg.sender == contractOwner);
		_;
	}	
	
	/// Returns the number of people waiting in line
	function qsize()
	public
	view
	returns(uint8)
	{
		return nOfUsers;
	}

	/// Returns whether the queue is empty or not
	function empty()
	public
	view
	returns(bool)
	{
		return (nOfUsers == 0);
	}
	
	/// Returns the address of the person in the front of the queue
	function getFirst()
	public
	view
	returns(address)
	{

		return queue[head];
	}
	
	/// Allows `msg.sender` to check their position in the queue
	function checkPlace()
	public
	view
	returns(uint8)
	{
		for (uint8 i = head; i != tail; i = (i+1) % size)
		{
			if (queue[i] == tx.origin)
			{
				return (size + i - head) % size;
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

		require(timestamp[head] + timeLimit >= block.timestamp, "Time is not up.");
		hasFinished[head] = true;
		emit TimeOut(queue[head]);
		dequeue();
	}
	
	/* Removes the first person in line; either when their time is up or when
	 * they are done with their purchase
	 */
	function dequeue()
	public
	{
		require(nOfUsers > 0, "Deleting from  Empty Queue .");
		require(hasFinished[head], "Stop Pushing.");
		head = (head + 1) % size;
		timestamp[head] = block.timestamp;
		nOfUsers--;
	}

	/// Places `addr` in the first empty position in the queue
	function enqueue(address addr)
	public
	{
		require(nOfUsers < size-1, "Adding to Full Queue .");
		queue[tail] = addr;
		hasFinished[tail] = false;
		tail = (tail + 1) % size;
		nOfUsers++;
	}

	function finished()
	public
	onlyContractOwner
	{
		hasFinished[head] = true;
	}
}
