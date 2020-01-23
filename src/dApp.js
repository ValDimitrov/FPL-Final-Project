// Do I have to import something here first?

var player1ID, player2ID;
var is_player1_set = false;
var is_player2_set = false;

web3Provider = null;
contracts = {};


async function initWeb3() {
    // Modern dapp browsers..
    if (window.ethereum) {
      web3Provider = window.ethereum;
      try {
        // Request account access
        await window.ethereum.enable();
      } catch (error) {
        // User denied account access..
        console.error("User denied account access");
      }
    } else {
        window.alert("Please install metamask and try again.");
    }

    return initContract();
    //return getPlayerIDs();
  }

initWeb3();

function initContract() {
    
  $.getJSON('FPLEscrow.json', function(data) {
    // Get the necessary contract artifact file and instantiate it with truffle-contract
    var FPLEscrowArtifact = data;
    contracts.FPLEscrow = TruffleContract(FPLEscrowArtifact);

    // Set the provider for our contract
    contracts.FPLEscrow.setProvider(web3Provider);
    
    return getPlayerIDs();
  });
}

function getPlayerIDs() {

    document.querySelector('.player-id').addEventListener('keypress', function (e) {
    
      if (e.key === 'Enter') {

        if (is_player1_set && is_player2_set) {
          return;
        }
          if (is_player1_set) {
            player2ID = document.getElementById("userInput"); //log the ID that was input as player 2
              player2_set = true;
        }   else if (!is_player1_set) {
            player1ID = document.getElementById("userInput"); //log the ID that was input as player 1
              is_player1_set = true;
        }

        
      // Prompt user to sign transaction (enter the game) with metamask

      console.log(is_player1_set, is_player2_set);
      console.log(player1ID, player2ID);

      }

  });

  // Send Player IDs to smart contract

}



















