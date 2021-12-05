var Crowdsale = artifacts.require("./Crowdsale.sol");
var Queue = artifacts.require("./Queue.sol");
var Token = artifacts.require("./Token.sol");
const BigNumber = require('bignumber.js');

module.exports = async function(deployer) {
//	await deployer.deploy(Token);
//	const token = await Token.deployed();
	let cap = new BigNumber(1000000000000000000);
	await deployer.deploy(Crowdsale, cap, 1);
	await deployer.deploy(Queue);
};
