// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";
contract WavePortal {
  uint256 totalWaves;
  address[] listOfSenders;

//  --- will they listen --- //
  event NewWave(address indexed from, uint256 timestamp, string message);




  struct Wave {
    address waver;
    string message;
    string userName;
    uint256 timestamp;
  }


  Wave[] waves;

  constructor() payable {
    console.log("Yo yo, I am a contract and I'm smart");
  }

  function wave(string memory _message,  string memory _userName) public {
    totalWaves += 1;
    console.log("%s has waved!", msg.sender);
    listOfSenders.push(msg.sender);


  // --- create array of struts --//
  waves.push(Wave(msg.sender, _message, _userName, block.timestamp));

  //  --- spread the news --//
  emit NewWave(msg.sender, block.timestamp, _message);

  uint256 prizeAmount = 0.0001 ether;
  require(prizeAmount <= address(this).balance,"Yo, this contract can't even pay you out!");

  (bool success, )=(msg.sender).call{value: prizeAmount}("");
  require(success, "Failed to withdraw money from contract ");
  }


function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

  function getTotalWaves() public view returns (uint256) {
    console.log("We have %d total waves!", totalWaves);

    return totalWaves;
  }



}