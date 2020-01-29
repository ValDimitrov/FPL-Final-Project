Avoiding Common Attacks

This game and its smart contract are really simple, which by definition helps it avoid many of the common attacks that we know. However, measures were still taken in order to try and avoid some common attacks. 

One common attack is forcibly sending ether to a contract. This can cause problems to contracts which use logic that depends on the contract balance.
The steps taken to mitigate this are: 
- Not using any logic that depends on the contract balance.
- Having a fallback function that does not have the payable modifier, thus making it almost impossible for people to randomly send ether to the contract without calling the proper functions (they can still use the "selfdestruct + use this contract as recepient" method, but that would not be an issue) 
- Overall making sure that the attacker would not gain anything by doing this, thus decentivizing them.

Another common attack is the DoS (Denial of Service) attack. In general, this is an attempt to disrupt normal traffic of a targeted app/dApp, service or network by overwhelming the target or its surrounding infrastructure with a flood of traffic. 
The steps taken to mitigate this are:
- Changing the status of each of the two players to set after they've entered the game (player1_set and player2_set variables). Then, if both players have entered, then when any new participant tries to enter the game, his transaction reverts.
- Also, the smart contract does not loop over arrays or do other similar operations, therefore the risk of reaching the Block Gas Limit before finishing is mitigated.
