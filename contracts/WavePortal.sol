// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";
contract WavePortal {
  uint256 totalWaves;
  address[] listOfSenders;

  constructor() {
    console.log("Yo yo, I am a contract and I'm smart ");
  }

  function wave() public {
    totalWaves += 1;
    console.log("%s has waved!", msg.sender);
    listOfSenders.push(msg.sender);
  }

  function getTotalWaves() public view returns (uint256) {
    console.log("We have %d total waves!", totalWaves);

    for(uint i; i < listOfSenders.length; i++){
      console.log("Log of all wavers %d  %d",i, listOfSenders[i] );
    }
    return totalWaves;
  }



}