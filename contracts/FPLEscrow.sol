pragma solidity ^0.5.0;

import "./SafeMath.sol";

contract FPLEscrow {
    using SafeMath for uint256;

    address arbiter;
    int256 public playerOneScore;
    int256 public playerTwoScore;
    PlayerInfo player1;
    PlayerInfo player2;
    bool public player1_set;
    bool public player2_set;
    uint256 playerID1; // ID of the player on the fantasy football site
    uint256 playerID2;
    bool private stopped = false; //Bool for emergency switch

    struct PlayerInfo {
        address payable playerAddress;
        uint256 playerID;

    }

    mapping(address => PlayerInfo) public Players;

    modifier onlyArbiter() { // Modifier so that only me (the arbiter) will be able to input results and initiate withdrawal to the winning player's address.
        require(msg.sender == arbiter);
        _;
    }

    function toggleContractActive() public onlyArbiter { //Emergency switch function
        stopped = !stopped;
    }

    modifier stopInEmergency {
        //if (!stopped)
        require(!stopped);
        _;
    }

    constructor() public {
        arbiter = msg.sender;
        player1_set = false;
        player2_set = false;
    }

    function deposit(uint256 _playerID) public payable stopInEmergency {

        if (player1_set && player2_set) {   // prevent further deposits after the second player
            revert();
        }
        if (player1_set) {
            player2 = PlayerInfo(msg.sender, _playerID);
            player2_set = true;
        } else if (!player1_set) {
            player1 = PlayerInfo(msg.sender, _playerID);
            player1_set = true;
        }
    }

    function payout() public payable onlyArbiter stopInEmergency {
        uint256 payment = address(this).balance;

        if (playerOneScore > playerTwoScore) {
            player1.playerAddress.transfer(payment);  // Need to send the funds to player 1's address
        } else if (playerTwoScore > playerOneScore) {
            player2.playerAddress.transfer(payment); // Need to send the funds to player 2's address
        }
        resetPlayers();
    }

    function setResults(int256 score_1, int256 score_2) public onlyArbiter {
        playerOneScore = score_1; //Scores will be checked by the arbiter on the official FPL site and input into the smart contract. An additional 1 point will be awarded if there is a draw (Fantasy PL tiebreak rules apply)
        playerTwoScore = score_2; 
        payout();
    }

    function resetPlayers() public onlyArbiter stopInEmergency {
        player1_set = false;
        player2_set = false;
    }

    uint256 public safeMathTestTotal; // Testing the SafeMath library even though we don't need it for this first version of the dApp.

    function testLibrary(uint256 var1, uint256 var2) public {
        safeMathTestTotal = var1.add(var2); // Testing the SafeMath library even though we don't need it for this first version of the dApp.
    }


    function() external { //fallback function - stops random ether from being sent by not having "payable" modifier
        v = 5; // Just something random
    }

    uint v;

}
