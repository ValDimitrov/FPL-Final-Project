pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/FPLEscrow.sol";

contract TestFPLEscrow {
    // The addresses of the fpl escrow contract that will be tested
    FPLEscrow fpl = FPLEscrow(DeployedAddresses.FPLEscrow());

    // Testing the initial state of the player1_set variable
    function testPlayer1SetInitialValue() public {

        bool player1Set = false;

        Assert.equal(fpl.player1_set(), player1Set, "player1_set should initially be false");
    }

    // Testing the initial state of the player2_set variable
    function testPlayer2SetInitialValue() public {

        bool player2Set = false;

        Assert.equal(fpl.player2_set(), player2Set, "player2_set should initially be false");
    }

    // Testing the initial state of the playerOneScore variable
    function testplayerOneScoreInitialValue() public {

        int256 _playerOneScore;

        Assert.equal(fpl.playerOneScore(), _playerOneScore, "playerOneScore should initially be null");
    }


    // Testing the initial state of the playerTwoScore variable
    function testplayerTwoScoreInitialValue() public {

        int256 _playerTwoScore;

        Assert.equal(fpl.playerTwoScore(), _playerTwoScore, "playerOneScore should initially be null");
    }

    // Testing that the arbiter's address is a match
    // function testAddress() public {

    //     address _arbiterAddress = 0x94c1be3eA0C8CEcC20A561b50178Ab9d590BEc34;

    //     Assert.equal(fpl.arbiter(), _arbiterAddress, "The addresses should match.");
    // }

    // Testing that the arbiter can call the payout function
    // function testAddress() public {

    //     address _arbiterAddress = 0x94c1be3eA0C8CEcC20A561b50178Ab9d590BEc34;

    //     Assert.equal(fpl.arbiter(), _arbiterAddress, "The addresses should match.");
    // }

}