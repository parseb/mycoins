// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "../src/ERC20GM.sol";

contract ERC20GMTest is DSTest {
    ERC20GM token;
    address[] initMintAddrs;
    uint256[] initMintAmts;

    function setUp() public {
        initMintAddrs = new address[](2);
        initMintAmts = new uint256[](2);

        initMintAddrs[0] = address(this);
        initMintAddrs[1] = address(0x1);

        initMintAmts[0] = 1000;
        initMintAmts[1] = 2000;

        token = new ERC20GM("ERC20GM Token", "ERC20GM", 1, initMintAddrs, initMintAmts);
    }

    function test_initial_setup() public {
        assertEq(token.name(), "ERC20GM Token");
        assertEq(token.symbol(), "ERC20GM");
        assertEq(token.price(), 1);
        assertEq(token.balanceOf(address(this)), 1000);
        assertEq(token.balanceOf(address(0x1)), 2000);
    }

    function test_mint() public {
        uint256 initialBalance = token.balanceOf(address(this));
        uint256 mintAmount = 100;
        uint256 requiredValue = token.howMuchFor(mintAmount);

        token.mint{value: requiredValue}(mintAmount);

        uint256 newBalance = token.balanceOf(address(this));
        assertEq(newBalance, initialBalance + mintAmount);
    }

    function testFail_mint_value_mismatch() public {
        uint256 mintAmount = 100;

        token.mint{value: 1}(mintAmount);
    }

    // function test_burn() public {
    //     uint256 initialBalance = token.balanceOf(address(this));
    //     uint256 burnAmount = 50;
    //     uint256 initialSupply = token.totalSupply();

    //     token.burn(burnAmount);

    //     uint256 newBalance = token.balanceOf(address(this));
    //     uint256 newSupply = token.totalSupply();

    //     assertEq(newBalance, initialBalance - burnAmount);
    //     assertEq(newSupply, initialSupply - burnAmount);
    // }

    function testFail_signal_invalid_price() public {
        uint256 invalidPrice = token.price() - 1;

        token.signal(invalidPrice);
    }

    function test_signal_strength() public {
        uint256 price = 2;
        uint256 signalStrengthBefore = token.signalStrength(price);

        token.signal(price);

        uint256 signalStrengthAfter = token.signalStrength(price);
        assertEq(signalStrengthAfter, signalStrengthBefore + token.balanceOf(address(this)));
    }

    function test_signal_of() public {
        uint256 price = 2;
        uint256[2] memory signalBefore = token.signalOf(address(this));

        token.signal(price);

        uint256[2] memory signalAfter = token.signalOf(address(this));
        assertEq(signalAfter[0], price);
        assertEq(signalAfter[1], token.balanceOf(address(this)));
    }
}
