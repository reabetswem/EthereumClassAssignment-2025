//Do not change the solidity version as it negatively impacts submission grading
pragma solidity ^0.8.2; 
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./MemeCoin.sol";

// TODO: make the Vendor contract Ownable
contract Vendor is Ownable {
    event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

    // NOTE: 1 token = 1 * 10**18 expressed in terms of the lowest units
    uint256 public constant tokensPerEth = 100;

    MemeCoin public memeCoin;

    // TODO: edit the constructor to set the owner's address
    constructor(address tokenAddress, address owner) Ownable(owner){
        memeCoin = MemeCoin(tokenAddress);
    }

    // TODO: create a payable buyTokens() function
    // NOTE: the purpose of this function is to trade the MC token for the ETH provided by the function called
    function buyTokens() public payable{

        // TODO: check that the msg.value is set
        require(msg.value > 0, "Send some ETH to buy tokens");

        // TODO: calculate the amount of tokens buyable
        // NOTE: tokens should be 10**18 i.e. expressed in the lowest unit
        uint256 tokensToBuy = msg.value * tokensPerEth;

        // TODO: check that vendor has enough tokens to sell to msg.sender

        uint256 vendorBalance = memeCoin.balanceOf(address(this));
        require(vendorBalance >= tokensToBuy, "Insufficient tokens in vendor contract");


        // TODO: transfer the tokens from the vendor to the msg.sender
        bool success = memeCoin.transfer(msg.sender, tokensToBuy);
        require(success, "Token transfer failed");


        // TODO: calculate any change left from the MC token purchase and refund any excess

        uint256 costInEth = tokensToBuy / tokensPerEth;
        uint256 excessEth = msg.value - costInEth;
        if (excessEth > 0) {
        (bool refundSuccess, ) = msg.sender.call{value: excessEth}("");
        require(refundSuccess, "Refund failed");
    }

        // TODO: emit a BuyTokens event
         emit BuyTokens(msg.sender, msg.value, tokensToBuy);
    }

    // TODO: create a withdraw() function that lets the owner withdraw ETH
    // NOTE: make sure only the owner can withdraw
    function withdraw() public onlyOwner {
        // TODO: check that the owner has a balance to withdraw first
        require(address(this).balance > 0, "No ETH to withdraw");
        
        // TODO: withdraw the total amount to the owner
        (bool success, ) = owner().call{value: address(this).balance}("");
        require(success, "Withdrawal failed");
    }

    // TODO: create a sellTokens(uint256 _amount) function:
    function sellTokens(uint256 _amount) public {

        // TODO: check that the requested tokens to sell > 0
        require(_amount > 0, "You need to sell some tokens");


        // TODO: check that the user has enough tokens to do the swap
        uint256 userBalance = memeCoin.balanceOf(msg.sender);
        require(userBalance >= _amount, "Not enough tokens");

        // TODO: check that the vendor has enough ETH to pay for the tokens
        uint256 ethToTransfer = _amount / tokensPerEth;
        require(address(this).balance >= ethToTransfer, "Insufficient ETH! Can't complete the transaction");


        // TODO: transfer tokens to the vendor and check for success
        bool tokenTransferSuccess = memeCoin.transferFrom(msg.sender, address(this), _amount);
        require(tokenTransferSuccess, "Token transfer failed");


        // TODO: transfer ETH to the seller and check for success
        (bool ethTransferSuccess, ) = msg.sender.call{value: ethToTransfer}("");
        require(ethTransferSuccess, "ETH transfer failed");
    }
}
