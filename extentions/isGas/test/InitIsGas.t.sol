// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/IsGas.sol";

contract ABC is IsGas {
    uint256 public A;

    constructor(address AAA, uint256 BBB) IsGas(AAA, BBB) {
        A = BBB;
    }
}

contract isGasTest is Test {
    ABC public isGas;

    function setUp() public {
        isGas = new ABC(address(123), 2);
    }

    function testIsInit() public {
        assertTrue(address(isGas).code.length > 0);
        assertTrue(isGas.A() == 2);
    }
}
