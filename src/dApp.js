// Do I have to import something here first?

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

    web3 = new Web3(web3Provider);
    return initContract();

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

  
  // How do I read playerIDs from smart contract as the arbiter.

  //How do I input the results as the arbiter?

}



















