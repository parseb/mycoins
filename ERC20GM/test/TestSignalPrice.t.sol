// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "./utils/Stage.t.sol";

contract SignalT is Test, Stage {
    IERC20GM iGM;

    function setUp() public {
        iGM = IERC20GM(InitDefaultInstance());

        vm.startPrank(address(111));
        iGM.transfer(address(30), 3 ether);
        iGM.transfer(address(20), 2 ether);
        iGM.transfer(address(10), 1 ether);
        iGM.transfer(address(40), 4 ether);

        iGM.transfer(address(100), 100 ether);
        vm.stopPrank();
    }

    function testBasicSignals(uint256 newP) public {
        uint256 p0 = iGM.price();
        vm.assume(newP > p0);
        vm.assume(newP < type(uint256).max / 10);

        vm.prank(address(30));
        iGM.signal(newP);

        assertTrue(p0 == iGM.price(), "price chage");

        vm.prank(address(30));
        iGM.signal(newP);
        assertTrue(p0 == iGM.price(), "price chage");

        vm.prank(address(40));
        iGM.signal(newP);
        assertTrue(p0 == iGM.price(), "price chage");

        vm.prank(address(40));
        iGM.signal(newP);
        assertTrue(p0 == iGM.price(), "price chage");

        vm.prank(address(30));
        iGM.signal(newP);
        assertTrue(p0 == iGM.price(), "price chage");

        vm.prank(address(100));
        iGM.signal(newP);
        assertTrue(p0 == iGM.price(), "price chage");

        vm.prank(address(111));
        iGM.signal(newP);
        assertTrue(newP == iGM.price(), "price did not chage");

        vm.expectRevert();
        vm.prank(address(111));
        iGM.signal(newP - 1);
        assertTrue(newP == iGM.price(), "price did chage");

        p0 = newP;
        newP = newP * 3;

        vm.prank(address(30));
        iGM.signal(newP);
        assertTrue(p0 == iGM.price(), "price chage");

        vm.prank(address(40));
        iGM.signal(newP);
        assertTrue(p0 == iGM.price(), "price chage");

        vm.prank(address(40));
        iGM.signal(newP);
        assertTrue(p0 == iGM.price(), "price chage");

        vm.prank(address(30));
        iGM.signal(newP);
        assertTrue(p0 == iGM.price(), "price chage");

        vm.prank(address(100));
        iGM.signal(newP);
        assertTrue(p0 == iGM.price(), "price chage");

        vm.prank(address(111));
        iGM.signal(newP);
        assertTrue(newP == iGM.price(), "price did not chage");

        uint256 tempP = iGM.price() + 33;
        assertTrue(iGM.signalStrength(tempP) == 0, "33 not 0");
        vm.prank(address(20));
        iGM.signal(tempP);
        assertTrue(iGM.signalStrength(tempP) > 1);
    }
}
