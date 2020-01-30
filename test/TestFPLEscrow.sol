pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/FPLEscrow.sol";

/// @notice Test contract that tests certain parts of the FPLEscrow smart contract.
contract TestFPLEscrow {
    FPLEscrow fpl = FPLEscrow(DeployedAddresses.FPLEscrow());

/// @notice Testing the initial state of the player1_set variable.
    function testPlayer1SetInitialValue() public {

        bool player1Set = false;

        Assert.equal(fpl.player1_set(), player1Set, "player1_set should initially be false");
    }

/// @notice Testing the initial state of the player2_set variable.
    function testPlayer2SetInitialValue() public {

        bool player2Set = false;

        Assert.equal(fpl.player2_set(), player2Set, "player2_set should initially be false");
    }

/// @notice Testing the initial state of the playerOneScore variable.
    function testplayerOneScoreInitialValue() public {

        int256 _playerOneScore;

        Assert.equal(fpl.playerOneScore(), _playerOneScore, "playerOneScore should initially be zero");
    }

/// @notice Testing the initial state of the playerTwoScore variable.
    function testplayerTwoScoreInitialValue() public {

        int256 _playerTwoScore;

        Assert.equal(fpl.playerTwoScore(), _playerTwoScore, "playerOneScore should initially be zero");
    }

/// @notice Testing that the SafeMath library works properly.
    // function testSMLibrary() public {

    //     uint256 var1 = 1;
    //     uint256 var2 = 3;
    //     uint256 sum = (var1 + var2);

    //     Assert.equal(fpl.testLibrary(1, 3), sum, "The sums should match");
    // }

}