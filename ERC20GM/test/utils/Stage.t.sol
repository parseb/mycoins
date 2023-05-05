// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "../../src/ERC20GM.sol";

contract Stage is Test {
    function InitDefaultInstance() public returns (address) {
        address[] memory beneficiaries = new address[](3);
        uint256[] memory amounts = new uint256[](3);

        beneficiaries[0] = address(111);
        beneficiaries[1] = address(222);
        beneficiaries[2] = address(333);

        amounts[0] = 1000 ether;
        amounts[1] = 1 ether;
        amounts[2] = 2 ether;

        return address(new ERC20GM("Fungible Governable Token", "FGT", 69, beneficiaries, amounts));
    }

    function InitDefaultWithPrice(uint256 p_, address[] memory beneficiaries_, uint256[] memory amounts_)
        public
        returns (address)
    {
        return address(new ERC20GM("Fungible Governable Token", "FGT", p_, beneficiaries_, amounts_));
    }
}
