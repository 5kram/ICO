// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./interfaces/ERC20Interface.sol";

/**
 * @title Token
 * @dev Contract that implements ERC20 token standard
 * Is deployed by `Crowdsale.sol`, keeps track of balances, etc.
 */

contract Token is ERC20Interface {
    address public owner;
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allow;

    constructor() {
        owner = tx.origin;
    }

	modifier onlyOrigin()
	{
		require(tx.origin == owner);
		_;
	}

    function initializeSupply(uint256 _initialSupply)
	public onlyOrigin
	{
        totalSupply = _initialSupply;
		balances[msg.sender] = totalSupply; 
    }

    function mint(uint256 _amount)
	public onlyOrigin
	returns(bool)
	{
        balances[owner] += _amount;
        totalSupply += _amount;
		return true;
    }

    function burn(uint256 _amount)
	public onlyOrigin
	payable
	returns(bool)
	{
        balances[msg.sender] -= _amount;
        totalSupply -= _amount;
		return true;
    }

    function balanceOf(address _owner)
        public
        view
        override
        returns (uint256 balance)
    {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value)
        public
        override
        returns (bool)
    {	
        require((_value > 0), "Not enough ");
        require(balances[msg.sender] >= _value, "Not enough balance");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value)
        public
        override
        returns (bool)
    {
		require(balanceOf(_spender) >= _value, "Not Enough Tokens in Balance.");
        allow[_spender][msg.sender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender)
        public
        view
        override
        returns (uint256)
    {
        return allow[_owner][_spender];
    }

    function transferFrom(address _from, address _to, uint256 _value)
	public
	override
	returns (bool) {
        require(balances[_from] >= _value && allow[_from][msg.sender] >= _value, "Value Can Not Be Accepted.");
        balances[_from] -= _value;
        balances[_to] += _value;
        allow[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}
