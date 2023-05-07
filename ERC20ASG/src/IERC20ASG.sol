// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {IERC20} from "openzeppelin-contracts/token/ERC20/IERC20.sol";

interface IERC20ASG is IERC20 {
    //// @notice mints specified amount to msg.sender requires corresponding value
    //// @param howMany_ number of tokens wanted
    function mint(uint256 howMany_) external payable;

    //// @notice burns amount provided sender has balanace. returns coresponding available value.
    //// @param howMany_ amount to burn
    function burn(uint256 howMany_) external;

    //// @notice burns, from sender. Does not return undelying value.
    function burnOnly(uint256 amount) external;
    
    //// @notice returns current price per unit
    function currentPrice() external view returns (uint256);

    //// @notice returns cost for mint for amount at current block
    //// @param amt_ amount of units to calculate price for
    function mintCost(uint256 amt_) external view returns (uint256);

    //// @notice returns cost for burn for given amount at current block
    //// @param amt_ amount of units to calculate price for
    function burnReturns(uint256 amt_) external view returns (uint256);
    
     //// @notice how many of this does ethAmount get you
    //// @param ethAmount_ amount of eth proposed as countervalue
    function howManyForThisETH(uint256 ethAmount_) external view returns (uint256);
}
