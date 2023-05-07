// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {IERC20C} from "./interfaces/IERC20custom.sol";

//// @notice imports function modifier as to make gas payable in configured token
//// @notice design to work with burnable tokens (ERC20GM or ERC20ASG) in this repo
//// @notice msg.sender pays and abstracts gas as token for dumdum user
//// @param ERC20Burnable_ address of token that can be intrinsecally priced in ETH
//// @param feeMultiplyer_ double, cover, 1000x, or nothing. [2,1,1000,0]
abstract contract IsGas {
    IERC20C Fungible;
    address immutable gERC;
    uint256 xFee;


    constructor(address ERC20Burnable_, uint256 feeMultiplyer_) {
        gERC = ERC20Burnable_;
        xFee = feeMultiplyer_;
        Fungible = IERC20C(ERC20Burnable_);
    }



    modifier localGas() {
        uint256 a = gasleft();
        _;
        uint256 b = (a - gasleft()) * tx.gasprice;
        
        a = Fungible.howManyForThisETH(b);
        Fungible.transferFrom(msg.sender, address(this), a);
        
        b = Fungible.burn(a);
        address(Fungible).call(){value: b};

    }
}
