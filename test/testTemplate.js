'use strict';

/* Add the dependencies you're testing */
const Crowdsale = artifacts.require("./Crowdsale.sol");
const Token = artifacts.require("./Token.sol");
const ERC20Interface = artifacts.require("./interfaces/ERC20Interface.sol");

contract('Token', function(accounts) {
	/* Define your view variables and instantiate viewly changing 
	 * ones
	 */
	const args = {};
	let x, y, z;
	let token, ico,tokenAddress, icoAddress

	beforeEach(async function() {
		/// Get the instance of Crawdsale.sol
		ico = await Crowdsale.deployed()
		/// Get the address of Crawdsale.sol
		icoAddress = await ico.address
		/// Get the address of the deployed Token.sol
		tokenAddress = await ico.tokenAddr.call()
		/// Get the instance of Token.sol by its address
		token = await Token.at(tokenAddress)
	});
	
	describe('Crawdsale deployment', function() {
		it("should have the correct initial supply", async function() {
			const cap = await ico.initialSupply.call()
			assert.equal(cap.toString(), '10000000000000000')
		});
		
		it("should have the correct balance", async function() {
			const balance = await token.balanceOf(icoAddress)
			assert.equal(balance.toString(), '10000000000000000')
		});

		it("should buy X tokens", async function() {
			await ico.buy({from: accounts[1], value:20000})
			const balance = await token.balanceOf(accounts[1])
			assert.equal(balance.toString(), '20000')
		});

		it("should sell X tokens", async function() {
			await ico.sell(20000, {from: accounts[1]})
			const balance = await token.balanceOf(accounts[1])
			assert.equal(balance.toString(), '0')
		});
		
	});
	

	describe('Your string here', function() {
		// CODE HERE
	});
});
