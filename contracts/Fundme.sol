// Get funds from users 
//withdraw funds
//set min funding value in usd

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;
   uint256 public minimumUsd=50*1e18;
   address[] public funders;
   mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable{
        // want  to be able to set a min fund
       
        require(msg.value.getConversionRate()>=minimumUsd,"You need to spend more ETH!");//1e18==1*10**18==1 eth
        //reverting undo any action before,and send reamining gas back
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]=msg.value;
    }

    
}
