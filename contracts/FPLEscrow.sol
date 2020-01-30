pragma solidity ^0.5.0;

/// @title Fantasy Premier League Head to Head Cryptocurrency Game
/// @author Valentin Dimitrov
/// @notice Only a very basic version of the game is implemented at this time

import "./SafeMath.sol";

contract FPLEscrow {
/// @dev Testing the SafeMath library even though we don't need it for this first version of the dApp.
    using SafeMath for uint256;

    address arbiter;
/// @notice Scores of the two players - necessary to find out who wins
/// @dev int instead of uint because a player can theoretically have a negative score
    int256 public playerOneScore;
    int256 public playerTwoScore;
    PlayerInfo player1;
    PlayerInfo player2;
    bool public player1_set;
    bool public player2_set;
/// @notice IDs of the players on the fantasy football site - necessary in order to check results and get player scores
    uint256 playerID1;
    uint256 playerID2;
/// @notice Bool for emergency switch
    bool private stopped = false;

    struct PlayerInfo {
        address payable playerAddress;
        uint256 playerID;

    }

    mapping(address => PlayerInfo) public Players;

/// @notice Modifier so that only me (the arbiter) will be able to input results and initiate withdrawal to the winning player's address.
    modifier onlyArbiter() {
        require(msg.sender == arbiter);
        _;
    }

/// @notice Emergency switch function
/// @dev Simple emergency switch function that only the arbiter controls and stops key functions from working if activated.
    function toggleContractActive() public onlyArbiter {
        stopped = !stopped;
    }

    modifier stopInEmergency {
        require(!stopped);
        _;
    }

/// @notice Contract constructor
    constructor() public {
        arbiter = msg.sender;
        player1_set = false;
        player2_set = false;
    }

/// @notice Receives the cryptocurrency of both players and logs their addresses and IDs
/// @dev A check is in place to prevent further deposits after the second player
/// @param _playerID The IDs of the two players of their fantasy football teams on the official site
    function deposit(uint256 _playerID) public payable stopInEmergency {

        if (player1_set && player2_set) {
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

/// @notice Checks who wins and pays out the ether, and then resets the game so that others can play
/// @dev onlyArbiter and emergency switch modifiers are present
    function payout() public payable onlyArbiter stopInEmergency {
        uint256 payment = address(this).balance;

        if (playerOneScore > playerTwoScore) {
            player1.playerAddress.transfer(payment);
        } else if (playerTwoScore > playerOneScore) {
            player2.playerAddress.transfer(payment);
        }
        resetPlayers();
    }

/// @notice Sets the results and calls the payout function. An additional 1 point will be awarded if there is a draw (FantasyPL tiebreak rules apply).
/// @dev onlyArbiter modifier is present.
/// @param score_1 The final scores of the two players (Single gameweek/weekend game).
/// @param score_2 The final scores of the two players (Single gameweek/weekend game).
    function setResults(int256 score_1, int256 score_2) public onlyArbiter {
        playerOneScore = score_1; //
        playerTwoScore = score_2;
        payout();
    }

/// @notice Resets the game when finished so others can play.
    function resetPlayers() public onlyArbiter stopInEmergency {
        player1_set = false;
        player2_set = false;
    }

/// @notice Getter functions for player1_set and player2_set. Used to alert users in the UI of contract changes.
/// @return true or false depending on whether there are currently players signed up for the game.
    function getPlayer1Status() public view returns(bool) {
        return player1_set;
    }

    function getPlayer2Status() public view returns(bool) {
        return player2_set;
    }

/// @notice Used by the arbiter to read the playerIDs in order to check the results.
/// @return The two playerIDs.
    function getPlayer1ID() public view onlyArbiter returns(uint256) {
        return player1.playerID;
    }

    function getPlayer2ID() public view onlyArbiter returns(uint256) {
        return player2.playerID;
    }

/// @notice Testing the SafeMath library even though we don't need it for this first version of the dApp.
    uint256 public safeMathTestTotal;

/// @notice Testing the SafeMath library even though we don't need it for this first version of the dApp.
/// @param var1 Two random numbers in order to test that the SafeMath library works properly
/// @param var2 Two random numbers in order to test that the SafeMath library works properly
    function testLibrary(uint256 var1, uint256 var2) public {
        safeMathTestTotal = var1.add(var2);
    }

/// @notice Fallback function.
/// @dev Stops random ether from being sent by not having "payable" modifier.
    function() external { //
        v = 5; // Just something random
    }

    uint v;

}
