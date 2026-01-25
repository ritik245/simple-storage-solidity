// Get funds from users 
//withdraw funds
//set min funding value in usd

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
   uint256 public minimumUsd=50;
    function fund() public payable{
        // want  to be able to set a min fund
       
        require(msg.value>minimumUsd,"You need to spend more ETH!");//1e18==1*10**18==1 eth
        //reverting undo any action before,and send reamining gas back
    }

    function getPrice() public view returns(uint256){
        // ABI
        //address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }
}
