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

	/// Deploy Token contract
	/// Initialize the total Supply of Tokens, the beggining and ending of ICO 
	constructor()
	{
		owner = msg.sender;
		token = new Token();
		token.initializeSupply(initialSupply);
		startTime = block.timestamp;
		endTime = startTime + 30 * 24 hours;
	}

    event Purchase(address indexed _who, uint256 _value);
    event Refund(address indexed _who, uint256 _value);

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

	function buy()
	public payable
	inTime
	{
		uint256 supply = token.totalSupply();
		uint256 tokens = msg.value.mul(rate);
		
		require(tokenSold < supply, "All Tokens Are Sold.");
		require(token.transfer(msg.sender, tokens), "Can Not Buy.");
		tokenSold += tokens;
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
	onlyOwner
	{
		token.burn(_amount);
	}

	function moveFunds()
	public
	onlyOwner
	{
		require(block.timestamp > endTime, "ICO is running.");
		payable(owner).transfer(address(this).balance);
	}
}
