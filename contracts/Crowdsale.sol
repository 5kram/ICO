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
	address public owner;
	uint256 public initialSupply = 10000000000000000;
	uint256 public tokenSold;
	uint256 public startTime;
	uint256 public endTime;
	uint256 public rate = 1;

	constructor(Token _token)
	{
		owner = msg.sender;
		token = _token;
		token.initializeSupply(initialSupply);
		startTime = block.timestamp;
		endTime = startTime + 30 * 24 hours;
	}

	modifier inTime() {
		require(block.timestamp > startTime && block.timestamp < endTime, "Not in time");
		_;
	}

	function buy()
	public payable
	inTime
	{
		// TODO: Require tokenSSold < totalSupply
		uint256 tokens = msg.value.mul(rate);
		require(token.transfer(msg.sender, tokens), "Could not buy.");
		tokenSold += msg.value;
	}

	function sell(uint256 _amount)
	public
	inTime
	{	
		uint256 inWei = _amount.div(rate);
		require(token.transfer(msg.sender, inWei), "Could not sell.");
		tokenSold -= _amount;
	}

	function remainingTime()
	public
	view
	returns(uint256)
	{
		return endTime - startTime;
	}
}
