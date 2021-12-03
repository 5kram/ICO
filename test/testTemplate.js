'use strict';

/* Add the dependencies you're testing */
const Crowdsale = artifacts.require("./Crowdsale.sol");
// CODE HERE

contract('testTemplate', function(accounts) {
	/* Define your view variables and instantiate viewly changing 
	 * ones
	 */
	const args = {};
	let x, y, z;
	// CODE HERE

	/* Do something before every `describe` method */
	beforeEach(async function() {
		// CODE HERE
	});

	/* Group test cases together 
	 * Make sure to provide descriptive strings for method arguements and
	 * assert statements
	 */
	describe('Your string here', function() {
		it("your string here", async function() {
			// CODE HERE
		});
		// CODE HERE
	});

	describe('Your string here', function() {
		// CODE HERE
	});
});
