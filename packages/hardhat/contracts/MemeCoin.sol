//Do not change the solidity version as it negatively impacts submission grading
pragma solidity ^0.8.2; 
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Vendor.sol";

contract MemeCoin is ERC20, Ownable{

    uint8 constant _decimals = 18; 
    Vendor public vendor;
    address public vendorAddress;

    // TODO: create a _totalSupply of 1000 tokens which has 18 decimal places
    uint256 constant _totalSupply = 1000 * 10 ** _decimals;

    constructor(address owner) ERC20("Meme Coin", "MC")  Ownable(owner) {
        // TODO: create a vendor smart contract. This contract will be responsible for buying and selling your token in ETH
         vendor = new Vendor(address(this), owner);
        // NOTE: smart contracts can deploy other smart cotnracts

        // TODO: assign the vendorAddress
        vendorAddress = address(vendor);

        // TODO: mint the _totalSupply of tokens to the vendor address
        _mint(vendorAddress, _totalSupply);   
        
        }
}
