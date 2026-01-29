// Get funds from users 
//withdraw funds
//set min funding value in usd

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./PriceConverter.sol";
//we can use coustam error instead of require to be gas efficent
error NotOwner();
contract FundMe {
    using PriceConverter for uint256;
   uint256 public constant minimumUsd=50*1e18; //constant immutable takes less gas use when you have const variable
   address[] public funders;
   mapping(address => uint256) public addressToAmountFunded;
   address public immutable owner; //using immutable when only assigned one time


   constructor(){
      owner =msg.sender;
   }

    function fund() public payable{
        // want  to be able to set a min fund
       
        require(msg.value.getConversionRate()>=minimumUsd,"You need to spend more ETH!");//1e18==1*10**18==1 eth
        //reverting undo any action before,and send reamining gas back
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]=msg.value;
    }

    function withdraw() public onlyOwner {
        //require(msg.sender== owner,"Sender is not owner");
        //for loop
        for(uint256 funderIndex=0;funderIndex < funders.length;funderIndex++){
            address funder=funders[funderIndex];
            addressToAmountFunded[funder]=0;
        }
        //reset array
        funders=new address[](0);
        // actually withdraw
        //transfer
        payable(msg.sender).transfer(address(this).balance);//if failed it will throw error
        //send
        bool sendSuccess=payable(msg.sender).send(address(this).balance);
        require(sendSuccess,"Send failed");//if failed will send bool message
        //call
        (bool callSuccess,)=payable(msg.sender).call{value:address(this).balance}("");
        require(callSuccess,"Call failed");

    }

    modifier onlyOwner  {
        //require(msg.sender==owner,"Sender is not owner!");
        if(msg.sender != owner){revert NotOwner();}
        _;
    }

    
}
