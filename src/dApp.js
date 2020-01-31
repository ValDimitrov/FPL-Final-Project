web3Provider = null;
contracts = {};

var game_in_progress = true;
var initial = true;

/// Instantiate web3 object
async function initWeb3() {
    // Metamask
    if (window.ethereum) {
      web3Provider = window.ethereum;
      try {
        // Request account access
        await window.ethereum.enable();
      } catch (error) {
        // Catch if the user denied account access.
        console.error("User denied account access");
      }
    } else {
        window.alert("Please install metamask and try again.");
    }

    web3 = new Web3(web3Provider);
    return initContract();

  }

initWeb3();

//Initiate smart contract
function initContract() {
    
  $.getJSON('FPLEscrow.json', function(data) {
    // Get the necessary contract artifact file and instantiate it with truffle-contract
    var FPLEscrowArtifact = data;
    contracts.FPLEscrow = TruffleContract(FPLEscrowArtifact);

    // Set the provider for our contract
    contracts.FPLEscrow.setProvider(web3Provider);
    
    testStatus();
    if (game_in_progress) {
      setInterval(testStatus, 1000);
    }

    return getPlayerIDs();
  });
}

// Initiate the transaction and get the player IDs
function getPlayerIDs() {

    document.querySelector('.player-id').addEventListener('keypress', function (e) {
    
      if (e.key === 'Enter') {
        var id = parseInt(document.getElementById("userInput").value);
        if (isNaN(id)){
          alert("It's a NaN. Please input a number.");
          return;
        }
        //call the contract deposit function
        var FPLinstance;
        web3.eth.getAccounts(function(error, accounts) {
          if (error) {
            console.log(error);
          }

          var account = accounts[0];

          contracts.FPLEscrow.deployed().then(function(instance) {
            FPLinstance = instance;

            return FPLinstance.deposit(id, {from: account, value: 10000000000000000}); //0.01 eth transaction per player
          })
          
        });

      }
  });
}

// Show current ethereum account selected in metamask in UI.
var account = web3.eth.accounts[0];

var accountInterval = setInterval(function() {
  if (web3.eth.accounts[0] !== account) {
    account = web3.eth.accounts[0];
    updateInterface();
  }
}, 100);


// Reflect smart contract state in the UI - show if game is still open or currently closed
async function checkPlayerStatuses(instance) {
  var player1set = await instance.getPlayer1Status();
  var player2set = await instance.getPlayer2Status();

  if (player1set && player2set) {
    alert("The game is now full. Please wait until it's over to sign up again.");
    game_in_progress = false;
  } else if(initial) {
    alert("The game is now open. You can enter.");
  }
  initial = false;
}

function testStatus(){
  if (game_in_progress) {
    contracts.FPLEscrow.deployed().then(function(instance) {
      checkPlayerStatuses(instance);
    });
  }
}

function updateInterface() {
  updateDisplayedAccountAddress(account);
}

function updateDisplayedAccountAddress(address) {
  document.getElementById("address").textContent = "Current account: " + address;
}

updateDisplayedAccountAddress(account);














