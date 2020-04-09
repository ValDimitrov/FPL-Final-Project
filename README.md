Fantasy Football Head to Head Cryptocurrency Game 

Final Project for Consensys Academy Developer Bootcamp Fall 2019

Author: Valentin Dimitrov

---
Project Summary: 
-	2 players want to play Fantasy Premier League (FPL) head to head (one vs one) using cryptocurrency (ether). 
-	They both come to a simple website, where they place their bet (0.01 eth), and they enter into the h2h game by sending their eth to the smart contract. 
-	When the player enters the game, their ether is deposited into the smart contract. This smart contract acts as an escrow. 
-	The smart contract has several functions, including a deposit, payout, and a setResults function, which will include the final scores of each player for the given weekend (this will be a weekend game).
-   There is also a toggleContractActive function which is an emergency switch, as well as a fallback function.
-	There is an arbiter (me), and only the arbiter inputs the correct results. This was decided after talks with Josh and Coogan so as not to overcomplicate the project by attempting to connect to the FPL API which is not trivial.
-	When the smart contract receives the final scores, it checks who has the higher score and sends the deposited ether (0.02 eth) to the winning player’s address.
---
How to Use:
-	Clone this github repo on your pc: https://github.com/ValDimitrov/FPL-Final-Project
- If you don't have nodejs, npm, truffle or metamask, install them first. Optionally also install ganache-gui.
-	Run a private blockchain with ganachi-gui or ganache-cli at port 8545. If using ganache-gui, make sure to add the project's "truffle-config.js" file in settings.
-   Type npm install in the command line while in the project folder in order to install all of the dependencies.
- 	Compile and deploy the smart contracts by typing truffle migrate in the command line while being in the project folder.
- 	Type npm run dev in order to start the lite server at localhost:3000

-   Please configure metamask by clicking on "Import account using seed phrase", pasting the seed phrase from your private ganache blockchain plus a simple password and choosing "localhost 8545" or "custom RPC" as network. Alternatively, if you don't want to do this, then you can import accounts one by one using the private key.

-	  The frontend will load and you should be prompted by metamask that "FPL Head To Head Game would like to connect to your account." Click connect.
- 	If this does not appear at first, please log out of your current metamask account and then refresh the page. The request should then appear.

-	  From metamask, choose an account for Player 1. Then type player 1's playerID in the box (just use 1) and click enter. Then accept the transaction for 0.01 eth. Player one is now entered into the game.
- 	From metamask, choose an account for Player 2. Then type player 2's playerID (just use 2) and click enter. Then accept the transaction for 0.01 eth. Player two is now also entered into the game.
- 	It is now up to the arbiter (me) to read the two playerIDs, check the results when the gameweek is over and call the setResults function with the player scores. 
-	The contract then pays out the ether to the winner and the game is over.
---
- 	At this stage there is no custom UI available for the arbiter (Again, decided so as not to overcomplicate the initial version of the project). If you wish to test the arbiter part as well, then:
- 	Go to remix.ethereum.org and click Solidity. There, at the "Deploy and run transactions" tab, choose "Web3 provider" as environment, and "http://localhost:8545" as endpoint.
-	After that, input the address of the FPLEscrow contract next to the blue "At Address" button. You can find this address by clicking on "Contracts" in ganache-gui. If necessary, import the smart contracts "FPLEscrow.sol" and "SafeMath.sol", found in the contracts folder, from your PC to Remix (by going to the file explorers tab and clicking on "Add local file to the browser explorer") and compile them.
-	Check the two playerIDs by calling the getter functions "getPlayer1ID" and "getPlayer2ID". Then, call the setResults function as the arbiter with the correct scores (just type "30, 25" as an example). The payout function is then called and the winning player receives the ether stored. The game is over.
---
Project has been tested and works on both Windows 10 and Ubuntu
