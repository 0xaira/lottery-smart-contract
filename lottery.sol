// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lottery {
    // Define the manager of the lottery.
    address public manager;
    
    // Define the minimum ticket price and the number of tickets required to select a winner.
    uint public minTicketPrice;
    uint public numTicketsToSelectWinner;
    
    // Define the list of players and the amount of ether they've contributed.
    address payable[] public players;
    mapping(address => uint) public playerToAmount;
    
    // Define the state of the lottery.
    enum State {
        Open,
        Closed,
        Completed
    }
    State public state;
    
    // Define events for when a player buys a ticket and when a winner is selected.
    event TicketBought(address player, uint amount);
    event WinnerSelected(address winner, uint amount);
    
    constructor(uint _minTicketPrice, uint _numTicketsToSelectWinner) {
        // Initialize the manager and the parameters of the lottery.
        manager = msg.sender;
        minTicketPrice = _minTicketPrice;
        numTicketsToSelectWinner = _numTicketsToSelectWinner;
        
        // Set the initial state of the lottery to Open.
        state = State.Open;
    }
    
    function buyTicket() public payable {
        // Check that the lottery is still Open.
        require(state == State.Open, "The lottery is not currently accepting tickets.");
        
        // Check that the ticket price is greater than or equal to the minimum ticket price.
        require(msg.value >= minTicketPrice, "The ticket price is less than the minimum ticket price.");
        
        // Add the player to the list of players and increment their contribution amount.
        players.push(payable(msg.sender));
        playerToAmount[msg.sender] += msg.value;
        
        // Emit an event indicating that the player has bought a ticket.
        emit TicketBought(msg.sender, msg.value);
    }
    
    function selectWinner() public {
        // Check that the lottery is Closed.
        require(state == State.Closed, "The lottery is not currently closed.");
        
        // Check that there are enough players to select a winner.
        require(players.length >= numTicketsToSelectWinner, "There are not enough players to select a winner.");
        
        // Generate a random index to select a winner.
        uint randomIndex = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, players.length))) % players.length;
        address payable winner = players[randomIndex];
        
        // Transfer the entire balance of the lottery to the winner.
        uint winnerAmount = address(this).balance;
        winner.transfer(winnerAmount);
        
        // Emit an event indicating that the winner has been selected.
        emit WinnerSelected(winner, winnerAmount);
        
        // Set the state of the lottery to Completed.
        state = State.Completed;
    }
    
    function closeLottery() public {
        // Check that the lottery is still Open.
        require(state == State.Open, "The lottery is not currently open.");
        
        // Check that the manager is calling this function.
        require(msg.sender == manager, "Only the manager can close the lottery.");
        
        // Set the state of the lottery to Closed.
        state = State.Closed;
    }
    
    function getPlayers() public view returns (address payable[] memory) {
        return players;
    }
    
    function getPlayerContribution(address player) public view returns (uint) {
        return playerToAmount[player];
    }
}
