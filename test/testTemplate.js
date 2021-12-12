'use strict';
/* Add the dependencies you're testing */
const Crowdsale = artifacts.require("./Crowdsale.sol");
const Token = artifacts.require("./Token.sol");
const Queue = artifacts.require("./Queue.sol");
const ERC20Interface = artifacts.require("./interfaces/ERC20Interface.sol");
const BigNumber = require('bignumber.js');


function tokens(n)
{
	return web3.utils.toWei(n, 'ether');
}

contract('Token', function(accounts) {
	/* Define your view variables and instantiate viewly changing 
	 * ones
	 */
	const args = {};
	let x, y, z;
	let token, ico,tokenAddress, icoAddress, queueAddress, queue;

	beforeEach(async function() {

		let cap = new BigNumber(1000000000000000000);
		/// Get the instance of Crawdsale.sol
		ico = await Crowdsale.deployed(cap, 1);
		/// Get the address of Crawdsale.sol
		icoAddress = await ico.address;
		/// Get the address of the deployed Token.sol
		tokenAddress = await ico.tokenAddr.call();
		/// Get the instance of Token.sol by its address
		token = await Token.at(tokenAddress);
		queueAddress = await ico.queueAddr.call();
		queue = await Queue.at(queueAddress);
	});
	
	describe('Deployment', function() {
		it("should have the correct initial supply", async function() {
			const cap = await token.totalSupply.call()
			assert.equal(cap.toString(), '1000000000000000000')
		});
		
		it("should have the correct balance", async function() {
			const balance = await token.balanceOf(icoAddress)
			assert.equal(balance.toString(), '1000000000000000000')
		});


	});

	describe('Transactions and buyers queue', function() {
		it("should get in line", async function() {
			await ico.getInLine({from: accounts[1]})
			await ico.getInLine({from: accounts[2]})
			const size = await queue.qsize()
			assert.equal(size.toString(), '2')
		});

		it("should be the first in line", async function() {
			const addr = await queue.getFirst.call()
			assert.equal(addr, accounts[1])
		});

		it("should buy X tokens", async function() {
		//	await ico.getInLine({from: accounts[1]})
		//	await ico.getInLine({from: accounts[2]})
			await ico.buy({from: accounts[1], value:20000})
			const balance = await token.balanceOf(accounts[1])
			assert.equal(balance.toString(), '20000')
		});

		it("should sell X tokens", async function() {
			await ico.sell(20000, {from: accounts[1]})
			const balance = await token.balanceOf(accounts[1])
			assert.equal(balance.toString(), '0')
		});

		it("should dequeue the buyer", async function() {
			const size = await queue.qsize.call()
			assert.equal(size.toString(), '1')
		});


		it("should set first in line correct", async function() {
			const addr = await queue.getFirst.call()
			assert.equal(addr, accounts[2])
		});

		it("should add buyers in line", async function() {
			await ico.getInLine({from: accounts[3]})
			await ico.getInLine({from: accounts[4]})
			await ico.getInLine({from: accounts[5]})
			await ico.getInLine({from: accounts[6]})
			const size = await queue.qsize.call()
			assert.equal(size.toString(), '5')
		});

		it("should buy X tokens", async function() {
			//	await ico.getInLine({from: accounts[1]})
			//	await ico.getInLine({from: accounts[2]})
				await ico.buy({from: accounts[2], value:20000})
				const balance = await token.balanceOf(accounts[2])
				assert.equal(balance.toString(), '20000')
		});
/*
		it("should kick first person out of line", async function() {
			await queue.checkTime();
			const size = await queue.qsize.call()
			assert.equal(size.toString(), '3')
		});

		it("should set the second person in line first", async function() {
			const addr = await queue.getFirst.call()
			assert.equal(addr, accounts[4])
		});
*/
	});
});
