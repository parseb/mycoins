// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {IERC20} from "openzeppelin-contracts/token/ERC20/IERC20.sol";

interface IERC20GM is IERC20 {
    //// @notice signals preference and returns current in-force price
    //// @param price_ prefered price amount in gwei
    function signal(uint256 price_) external returns (uint256);

    //// @notice mints specified amount to msg.sender requires corresponding value
    //// @param howMany_ number of tokens wanted
    function mint(uint256 howMany_) external payable;

    //// @notice burns amount provided sender has balanace. returns calculated
    //// @param howMany_ amount to burn
    function burn(uint256 howMany_) external;

    //// @notice calculates how much specified howMany costs for value sent
    //// @param howMany_ how many
    //// @return returns total value of how many times price
    function howMuchFor(uint256 howMany_) external view returns (uint256);

    //// @notice calculates how much specified howMany costs for value sent
    //// @param howMany_ how many
    //// @return returns total value of how many times price
    function refundQtFor(uint256 howMany_) external view returns (uint256);

    //// @notice retrieves in-force price
    function price() external view returns (uint256);

    //// @notice retrieves strenght of specified unrealized price
    //// @param p_ price to check cummulative strenght of
    function signalStrength(uint256 p_) external view returns (uint256);

    //// @notice retrieves current user signal state
    //// @param whom_ address of agent to
    function signalOf(address whom_) external view returns (uint256[2] memory);
}
