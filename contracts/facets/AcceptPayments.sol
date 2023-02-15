// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "../libraries/LibAtlatenNFTPayment.sol";
import "@solidstate/contracts/access/ownable/SafeOwnable.sol";

contract AcceptPayments is SafeOwnable {


    function acceptPayments(
        address royaltyRecipient,
        address seller,
        address admin, 
        uint256 sellerAmount, 
        uint8 royaltyPercentage, 
        uint8 AdminPercentage) payable external {
            
            require(royaltyRecipient != address(0), "Invalid Royalty Recipient Address");
            require(seller != address(0), "Invalid Seller Address");
            require(admin != address(0), "Invalid admin Address");
            require(msg.value == sellerAmount, "Your Enter Low Amount");

            LibAtlatenNFTPayment.acceptPayments(royaltyRecipient,seller,admin,sellerAmount,royaltyPercentage,AdminPercentage);
    }
    
    }