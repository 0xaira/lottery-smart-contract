# Lottery Smart Contract

This is a simple lottery system implemented as a smart contract in Solidity. The contract allows players to buy tickets and randomly select a winner after the lottery is closed. The contract also ensures that the minimum ticket price is met and prevents unauthorized parties from manipulating the lottery.

## Getting Started

To get started, you will need to install the Solidity compiler and a development blockchain like Ganache. You can then compile and deploy the smart contract using tools like Remix or Truffle. Once the contract is deployed, you can interact with it using a web3.js library or a tool like Remix.

## Usage

Here are the main functions and parameters of the Lottery smart contract:

### Parameters

- `minTicketPrice`: the minimum amount of ether required to purchase a ticket
- `numTicketsToSelectWinner`: the number of tickets to select a winner from (must be less than or equal to the total number of players)

### Functions

- `buyTicket()`: allows players to buy tickets by sending ether to the contract
- `selectWinner()`: allows the manager to select a winner from the list of players
- `closeLottery()`: allows the manager to close the lottery and prevent further ticket purchases
- `getPlayers()`: returns the list of players who have bought tickets
- `getPlayerContribution()`: returns the amount of ether contributed by a particular player

### Events

- `TicketBought`: emitted when a player buys a ticket
- `WinnerSelected`: emitted when the manager selects a winner


## Contributing

Contributions are welcome! If you find a bug or have an idea for an improvement, please open an issue or submit a pull request.


