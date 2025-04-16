//Do not change the solidity version as it negatively impacts submission grading
pragma solidity ^0.8.2; 
// SPDX-License-Identifier: MIT

import "./MemeCoin.sol";

// TODO: make the Vendor contract Ownable
contract Vendor {
    event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

    // NOTE: 1 token = 1 * 10**18 expressed in terms of the lowest units
    uint256 public constant tokensPerEth = 100;

    MemeCoin public memeCoin;

    // TODO: edit the constructor to set the owner's address
    constructor(address tokenAddress, address owner) {
        memeCoin = MemeCoin(tokenAddress);
    }

    // TODO: create a payable buyTokens() function
    // NOTE: the purpose of this function is to trade the MC token for the ETH provided by the function called
    function buyTokens() public {

        // TODO: check that the msg.value is set

        // TODO: calculate the amount of tokens buyable
        // NOTE: tokens should be 10**18 i.e. expressed in the lowest unit

        // TODO: check that vendor has enough tokens to sell to msg.sender

        // TODO: transfer the tokens from the vendor to the msg.sender

        // TODO: calculate any change left from the MC token purchase and refund any excess

        // TODO: emit a BuyTokens event
        // emit BuyTokens(msg.sender, msg.value, tokensToBuy);
    }

    // TODO: create a withdraw() function that lets the owner withdraw ETH
    // NOTE: make sure only the owner can withdraw
    function withdraw() public {
        // TODO: check that the owner has a balance to withdraw first

        // TODO: withdraw the total amount to the owner
    }

    // TODO: create a sellTokens(uint256 _amount) function:
    function sellTokens(uint256 _amount) public {

        // TODO: check that the requested tokens to sell > 0

        // TODO check that the user has enough tokens to do the swap

        // TODO: check that the vendor has enough ETH to pay for the tokens

        // TODO: transfer tokens to the vendor and check for success

        // TODO: transfer ETH to the seller and check for success
    }
}
