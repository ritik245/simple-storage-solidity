//SPDX-License-Idendifier: MIT
pragma solidity ^0.8.18;

import "./SimpleStorage.sol";

contract ExtraStorage is SimpleStorage {
    //+5
    //override
    function store(uint256 _favoriteNumber) public override {
        favoriteNumber= _favoriteNumber+5;
    }
}