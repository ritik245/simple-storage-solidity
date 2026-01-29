//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract FallbackExample{
    uint256 public result;

    receive() external payable { //this will trigger when ever a transction is made in this contract
        result=1;
    }
}