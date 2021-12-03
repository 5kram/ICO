// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
 * @title Math
 * @dev Assorted math operations
 * As seen here: https://github.com/OpenZeppelin/zeppelin-solidity/blob/master/contracts/math/Math.sol
 */

library Math {
  function max64(uint64 a, uint64 b) internal pure returns (uint64) {
    return a >= b ? a : b;
  }

  function min64(uint64 a, uint64 b) internal pure returns (uint64) {
    return a < b ? a : b;
  }

  function max256(uint256 a, uint256 b) internal pure returns (uint256) {
    return a >= b ? a : b;
  }

  function min256(uint256 a, uint256 b) internal pure returns (uint256) {
    return a < b ? a : b;
  }
}