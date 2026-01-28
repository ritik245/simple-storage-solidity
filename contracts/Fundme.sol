// Get funds from users 
//withdraw funds
//set min funding value in usd

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
   uint256 public minimumUsd=50*1e18;
   address[] public funders;
   mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable{
        // want  to be able to set a min fund
       
        require(getConversionRate(msg.value)>=minimumUsd,"You need to spend more ETH!");//1e18==1*10**18==1 eth
        //reverting undo any action before,and send reamining gas back
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]=msg.value;
    }

    function getPrice() public view returns(uint256){
        // ABI
        //address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int price,,,)= priceFeed.latestRoundData();
        //ETH in terms of USD
        // 3000.00000000
        return uint256(price*1e10);

    }
    //1eth=10^8Wei=10^9Gwei

    function getVersion() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint ethPrice=getPrice();
        uint ethAmountInUsd= (ethPrice * ethAmount)/1e18;
        return ethAmountInUsd;
    }
}
