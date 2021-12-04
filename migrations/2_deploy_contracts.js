var Crowdsale = artifacts.require("./Crowdsale.sol");
var Queue = artifacts.require("./Queue.sol");
var Token = artifacts.require("./Token.sol");

module.exports = async function(deployer) {
	await deployer.deploy(Token);
	const token = await Token.deployed();
	await deployer.deploy(Crowdsale);
	await deployer.deploy(Queue);
};
