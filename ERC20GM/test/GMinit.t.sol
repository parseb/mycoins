// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "./utils/Stage.t.sol";

contract GMinitTest is Test, Stage {
    IERC20GM iGM;

    function setUp() public {
        iGM = IERC20GM(InitDefaultInstance());
    }

    function testIsInit() public {
        assertTrue(address(iGM).code.length > 0, "codesize is 0");
    }

    function testInitPrice(uint256 p_) public {
        vm.assume(p_ > 0);
        address[] memory beneficiaries = new address[](3);
        uint256[] memory amounts = new uint256[](3);

        beneficiaries[0] = address(111);
        beneficiaries[1] = address(222);
        beneficiaries[2] = address(333);

        amounts[0] = 100 ether;
        amounts[1] = 1 ether;
        amounts[2] = 2 ether;

        iGM = IERC20GM(InitDefaultWithPrice(p_, beneficiaries, amounts));

        assertTrue(iGM.price() > 0);
    }
}
