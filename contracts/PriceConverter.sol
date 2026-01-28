//SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";



library PriceConverter{
    function getPrice() internal view returns(uint256){
        // ABI
        //address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int price,,,)= priceFeed.latestRoundData();
        //ETH in terms of USD
        // 3000.00000000
        return uint256(price*1e10);

    }
    //1eth=10^8Wei=10^9Gwei

    function getVersion() internal view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256){
        uint ethPrice=getPrice();
        uint ethAmountInUsd= (ethPrice * ethAmount)/1e18;
        return ethAmountInUsd;
    }
}