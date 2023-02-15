// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract AtlatenNFTPayment is Ownable {
    
    address public ATLATAN_ADMIN_WALLET;

    constructor() {
        
        ATLATAN_ADMIN_WALLET = _msgSender();
    }

    event PaymentsAccepted(

        address _royaltyRecipient,
        uint256 _royaltyfeeAmount,
        address _seller,
        uint256 _sellerfeeAmount,
        address _admin, //0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B
        uint256 _adminfeeAmount
    );

    function setAtlatanAdminWallet(address _wallet) public onlyOwner {
        require(_wallet != address(0), "address invalid");
        ATLATAN_ADMIN_WALLET = _wallet;
    }

    function _calculateFeePercentage(uint256 _amount, uint8 _percentage) pure internal returns (uint256) {
        uint256 _feeAmount = (_amount*_percentage) / 100;
        return _feeAmount;
    }

    function transferServiceFee(address _receiver, uint256 _amount) internal {
        payable(_receiver).transfer(_amount);
    }

    function acceptPayments(
        address royaltyRecipient,
        address seller, 
        address admin, 
        uint256 sellerAmount,
        uint8 royaltyPercentage,
        uint8 AdminPercentage 
        ) payable public {
            
            require(royaltyRecipient != address(0), "Invalid Royalty Recipient Address");
            require(seller != address(0), "Invalid Seller Address");
            require(admin != address(0), "Invalid admin Address");
            require(msg.value == sellerAmount, "Your Enter Low Amount");

            uint256 royaltyfeeAmount = _calculateFeePercentage(sellerAmount, royaltyPercentage);
            uint256 adminfeeAmount = _calculateFeePercentage(sellerAmount, AdminPercentage);
            uint256 sellerfeeAmount = sellerAmount - (royaltyfeeAmount + adminfeeAmount);

            transferServiceFee(admin, adminfeeAmount);
            transferServiceFee(seller, sellerfeeAmount);
            transferServiceFee(royaltyRecipient, royaltyfeeAmount);

            emit PaymentsAccepted(royaltyRecipient, royaltyfeeAmount, seller, sellerfeeAmount, admin, adminfeeAmount);

        }
}
