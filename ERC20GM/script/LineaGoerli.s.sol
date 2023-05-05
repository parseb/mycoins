// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import "../src/ERC20GM.sol";

contract LineaDeploy is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast(vm.envUint("gnosis_pvk")); //// start 1

        address[] memory beneficiaries = new address[](3);
        uint256[] memory amounts = new uint256[](3);

        beneficiaries[0] = 0xb3F204a5F3dabef6bE51015fD57E307080Db6498;
        beneficiaries[1] = 0xE7b30A037F5598E4e73702ca66A59Af5CC650Dcd;
        beneficiaries[2] = address(1337);

        amounts[0] = 1000 ether;
        amounts[1] = 1 ether;
        amounts[2] = 2 ether;

        address FGM = address(new ERC20GM("Fungible Governable Token", "FGT", 5000 gwei, beneficiaries, amounts));

        console.log("FGM tokend deployed at : ", FGM);
    }
}
