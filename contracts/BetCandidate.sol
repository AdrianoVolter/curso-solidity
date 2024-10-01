// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

struct Bet{
    uint amount;
    uint candidate;
    uint timestamp;
    uint claimed;
}

struct Dispute{
    string candidate1;
    string candidate2;
    string image1;
    string image2;
    uint total1;
    uint total2;
    uint winner;

}

contract BetCandidate{

    Dispute public dispute;
    mapping (address => Bet)public allBets;

    address owner;
    uint fee = 1000;

    constructor(){
        owner = msg.sender;
        dispute = Dispute({
            candidate1 : "D. Trump",
            candidate2 : "K. Harris",
            image1 : "http://bit.ly/3zmSfiA",
            image2 : "http://bit.ly/4gF4mYO",
            total1 : 0,
            total2 : 0,
            winner : 0
        });
    }

    function bet(uint candidate) external payable {
        require(candidate == 1 || candidate == 2, "Invalid Candidate");
        require(msg.value > 0, "Invalid bet");
        require(dispute.winner == 0, "Dispute already closed");

        Bet memory newBet;
        newBet.amount = msg.value;
        newBet.candidate = candidate;
        newBet.timestamp = block.timestamp;

        allBets[msg.sender]= newBet;

        if(candidate == 1)
            dispute.total1 += msg.value;
        else 
            dispute.total2 += msg.value;
        
    }

    function finish(uint winner) external {
        require(msg.sender == owner, "Invalid account");
        require(winner == 1 || winner == 2, "Invalid Candidate");
        require(dispute.winner == 0, "Dispute already closed");

        dispute.winner = winner;

        uint grossPrize = dispute.total1 + dispute.total2;
        uint comission = (grossPrize * fee) / 1e4;
    }
}