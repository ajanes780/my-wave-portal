// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";
contract WavePortal {
  uint256 totalWaves;
  address[] listOfSenders;
  uint256 private seed;
//  --- will they listen --- //
  event NewWave(address indexed from, uint256 timestamp, string message, string userName);




  struct Wave {
    address waver;
    string message;
    string userName;
    uint256 timestamp;
  }


  Wave[] waves;

  constructor() payable {
    console.log("Yo yo, I am a contract and I'm smart");
    seed = (block.timestamp + block.difficulty) % 100;
  }

  mapping(address => uint256) public lastWavedAt;

  function wave(string memory _message,  string memory _userName) public {
    // require(
    //           lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
    //           "Wait 15m"
    //       );

    require(lastWavedAt[msg.sender] + 30 seconds < block.timestamp, "Must wait 30 seconds before waving again.");

    lastWavedAt[msg.sender] = block.timestamp;

    totalWaves += 1;
    console.log("%s has waved!", msg.sender);
    listOfSenders.push(msg.sender);
    seed = (block.difficulty + block.timestamp + seed) % 100;




  // --- create array of struts --//
  waves.push(Wave(msg.sender, _message, _userName, block.timestamp));




      if (seed <= 50) {
        console.log("%s won!", _userName);

        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "contract is broke ass no prize for you."
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }

  emit NewWave(msg.sender, block.timestamp, _message, _userName);
 }
  //  --- spread the news --//



function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

  function getTotalWaves() public view returns (uint256) {
    console.log("We have %d total waves!", totalWaves);

    return totalWaves;
  }



  }