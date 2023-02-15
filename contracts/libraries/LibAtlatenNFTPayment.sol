// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library LibAtlatenNFTPayment{
    bytes32 internal constant NAMESPACE = keccak256("lib.atlaten");

    event PaymentsAccepted(

        address _royaltyRecipient,
        uint256 _royaltyfeeAmount,
        address _seller,
        uint256 _sellerfeeAmount,
        address _admin,
        uint256 _adminfeeAmount
    );

    struct AtlatenStorage {
    address royaltyRecipient;
    address seller;
    address admin;
    uint256 sellerAmount;
    uint8 royaltyPercentage;
    uint8 adminPercentage;
    }


    function getStorage() internal pure returns (AtlatenStorage storage atlatenStorage) {
        bytes32 position = NAMESPACE;
        assembly {
            atlatenStorage.slot := position
        }
    }

    function transferServiceFee(address _receiver, uint256 _amount) internal {
        payable(_receiver).transfer(_amount);
    }

    function _calculateFeePercentage(uint256 _amount, uint8 _percentage) pure internal returns (uint256) {
        uint256 _feeAmount = (_amount*_percentage) / 100;
        return _feeAmount;
    }
    
    function acceptPayments(
        address _royaltyRecipient,
        address _seller, 
        address _admin, 
        uint256 _sellerAmount,
        uint8 _royaltyPercentage,
        uint8 _adminPercentage 
        ) internal {
            
            AtlatenStorage storage atlatenStorage = getStorage();
            atlatenStorage.royaltyRecipient = _royaltyRecipient;
            atlatenStorage.seller = _seller;
            atlatenStorage.admin = _admin;
            atlatenStorage.sellerAmount = _sellerAmount;
            atlatenStorage.royaltyPercentage = _royaltyPercentage;
            atlatenStorage.adminPercentage = _adminPercentage;
            
            
            uint256 royaltyfeeAmount = _calculateFeePercentage(atlatenStorage.sellerAmount, atlatenStorage.royaltyPercentage);
            uint256 adminfeeAmount = _calculateFeePercentage(atlatenStorage.sellerAmount, atlatenStorage.adminPercentage);
            uint256 sellerfeeAmount = atlatenStorage.sellerAmount - (royaltyfeeAmount + adminfeeAmount);

            transferServiceFee(atlatenStorage.admin, adminfeeAmount);
            transferServiceFee( atlatenStorage.seller, sellerfeeAmount);
            transferServiceFee(atlatenStorage.royaltyRecipient, royaltyfeeAmount);

            emit PaymentsAccepted(atlatenStorage.royaltyRecipient, royaltyfeeAmount, atlatenStorage.seller, sellerfeeAmount, atlatenStorage.admin, adminfeeAmount);

        }
}

