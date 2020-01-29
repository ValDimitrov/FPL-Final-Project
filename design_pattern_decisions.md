Design Decisions
---
This file contains a quick overview of the design patterns used and decisions that I've made during the development of this project.
I have to mention again that this first version of the game is very simple, therefore it's fairly straightforward. Still, it made sense to design certain parts in a specific way.

1. Making the game head to head, or only playable by two players at a time.
- Daily fantasy sports is now a big thing, especially in the US. In these games, many people can play against eachother at the same time. However, as someone who is brand new to blockchain development, I decided that it would be better to start with a game that is as simple as possible so that I can focus more on learning the fundamentals. Therefore, it made sense to make the game only playable by two players at a time.

2. Restricting access to key dApp functionality.
- As the smart contract functions like an escrow, it was crucial to implement modifiers so that only the arbiter can call the setResults and payout functions. Otherwise, any of the players could cheat by calling the setResults function themselves with fake scores. 
- The arbiter is also the only one that can reset the player1_set and player2_set variables, making him in effect the only one that can "restart" the game so that new players may enter.

3. Implementing an emergency switch.
- Even though the smart contract is quite simple and everything seems to work, it's better to be safe than sorry. Therefore, a simple emergency switch is implemented which allows only the contract creator to freeze key functions in order to reduce harm if a bug is detected.
