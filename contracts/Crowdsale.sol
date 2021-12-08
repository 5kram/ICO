// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import './Queue.sol';
import './Token.sol';
import "./utils/SafeMath.sol";

/**
 * @title Crowdsale
 * @dev Contract that deploys `Token.sol`
 * Is timelocked, manages buyer queue, updates balances on `Token.sol`
 */

contract Crowdsale
{
	using SafeMath for uint256;
	Token public token;
	address public tokenAddr;
	address public queueAddr;
	address public owner;
	uint256 public tokenSold;
	uint256 public startTime;
	uint256 public endTime;
	uint256 public rate;
	uint256 public cap;

	Queue public queue;

	/// Deploy Token contract
	/// Initialize the total Supply of Tokens, the beggining and ending of ICO 
	constructor(uint256 _cap, uint256 _rate)
	{
		owner = msg.sender;
		token = new Token();
		queue = new Queue();
		tokenAddr = address(token);
		queueAddr = address(queue);
		cap = _cap;
		token.initializeSupply(cap);
		startTime = block.timestamp;
		endTime = startTime + 30 * 24 hours;
		rate = _rate;
	}

    event Purchase(address indexed _who, uint256 _value);
    event Refund(address indexed _who, uint256 _value);
	event Burn(address indexed _who, uint256 _value);

	modifier inTime()
	{
		require(block.timestamp > startTime && block.timestamp < endTime, "Not In Time.");
		_;
	}

	modifier onlyOwner()
	{
		require(msg.sender == owner);
		_;
	}

	function getInLine()
	public
	{
		require(queue.qsize() <= 5, "Queue Is Full.");
		queue.enqueue(msg.sender);
	}

	function buy()
	public payable
	inTime
	{
		require((queue.qsize() > 1) && queue.getFirst() == msg.sender, "Not first or not someone else in line.");
		uint256 supply = token.totalSupply();
		uint256 tokens = msg.value.mul(rate);
		
		require(tokenSold < supply, "All Tokens Are Sold.");
		require(token.transfer(msg.sender, tokens), "Can Not Buy.");
		tokenSold += tokens;
		/// getFirst uses LIFO order, users[0] is the first added in the queue
		queue.finished();
		queue.dequeue();
		emit Purchase(msg.sender, tokens);
	}

	function sell(uint256 _amount)
	public
	inTime
	{	
		uint256 inWei = _amount.div(rate);
		token.approve(msg.sender, _amount);
		require(token.transferFrom(msg.sender, address(this), _amount), "Can Not Sell.");
		payable(msg.sender).transfer(inWei);
		tokenSold -= _amount;
		emit Refund(msg.sender, _amount);
	}

	function remainingTime()
	public
	view
	returns(uint256)
	{
		return endTime - startTime;
	}

	function mintTokens(uint256 _amount)
	public
	onlyOwner
	{
		token.mint(_amount);
	}

	function burnTokens(uint256 _amount)
	public
	{
		token.burn(_amount);
		if(msg.sender != owner)
		{
			emit Burn(msg.sender, _amount);
		}
	}

	function moveFunds()
	public
	onlyOwner
	{
		require(block.timestamp > endTime, "ICO is running.");
		payable(owner).transfer(address(this).balance);
	}
}
