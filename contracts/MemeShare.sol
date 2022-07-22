 // SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MemeShare {
    uint256 totalMemes;

    mapping (address => uint) ownerToMemes;
    mapping(address => uint256) public lastMemedAt;

    event NewMeme(address indexed from, uint256 timestamp, string url);

    struct Meme {
        address memer; // The address of the user who memed.
        string url; // The url the user sent.
        uint256 timestamp; // The timestamp when the user memed.
    }
   
    Meme[] memes;

    uint256 private seed;

    constructor() payable {
        console.log("I AM SMART CONTRACT.");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function meme(string memory _memeUrl) public {
        require(
            lastMemedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );

        lastMemedAt[msg.sender] = block.timestamp;

        totalMemes += 1;
        console.log("%s memed w/ message %s", msg.sender, _memeUrl);
        ownerToMemes[msg.sender]++;
        console.log("%s has memed %s total times!", msg.sender, 
            ownerToMemes[msg.sender]);

        memes.push(Meme(msg.sender, _memeUrl, block.timestamp));


        emit NewMeme(msg.sender, block.timestamp, _memeUrl);

        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random # generated: %d", seed);

        if (seed < 5) {
            console.log("%s won!", msg.sender);
                    uint256 prizeAmount = 0.00001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }
    }

    function getAllMemes() public view returns (Meme[] memory) {
        return memes;
    }

    function getTotalMemes() public view returns (uint256) {
        console.log("We have %d total memes!", totalMemes);
        return totalMemes;
    }
}