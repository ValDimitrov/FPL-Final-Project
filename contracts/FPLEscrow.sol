pragma solidity ^0.5.0;

contract FPLEscrow {

    address arbiter;
    int256 playerOneScore;
    int256 playerTwoScore;
    PlayerInfo player1;
    PlayerInfo player2;
    bool player1_set = false;
    bool player2_set = false;
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
        if (!stopped)
        _;
    }

    constructor() public {
        arbiter = msg.sender;
    }

    function deposit(uint256 _playerID) public payable stopInEmergency {
        //TODO - ask mentor what happens if a third player deposits money and we do nothing with it - should just be sent along with the rest to the winner? No.

        // prevent further deposits after the second player
        if (player1_set && player2_set) {   // require(msg.value % 2 == 0, "Even value required.");
            return;
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
    }

    function setResults(int256 score_1, int256 score_2) public onlyArbiter {
        playerOneScore = score_1; //Here these scores will be checked by the arbiter on the official FPL site and input into the smart contract. An additional 1 point will be awarded if there is a draw to the player with a better tiebreak record (Fantasy PL rules apply)
        playerTwoScore = score_2;
        payout();
    }



    function() external { //fallback function - stops random ether from being sent by to not having "payable" modifier
        v = 5;
    }

    uint v;

    //Tests - see notes

}