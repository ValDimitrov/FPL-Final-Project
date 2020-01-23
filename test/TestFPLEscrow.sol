pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/FPLEscrow.sol";

contract TestFPLEscrow {
    // The addresses of the fpl escrow contract that will be tested
    FPLEscrow fpl = FPLEscrow(DeployedAddresses.FPLEscrow());

    // Testing the deposit() function
    function testDoesPlayer1Set() public {
        
        bool player1NotSet = false;


        Assert.equal(fpl(player1_set), player1NotSet, "Both should be initially false");
    }



}