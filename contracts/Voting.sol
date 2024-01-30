// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    Candidate[] public candidates; //array of struct
    address owner;
    mapping(address => bool) public voters;//mapping address bool, it maps if a voter has voted or not

    uint256 public votingStart; //voting time
    uint256 public votingEnd; 

constructor(string[] memory _candidateNames, uint256 _durationInMinutes) {  //constructor
    for (uint256 i = 0; i < _candidateNames.length; i++) {
        candidates.push(Candidate({
            name: _candidateNames[i],
            voteCount: 0 //every candidates vote count will be zero
        }));
    }
    owner = msg.sender;
    votingStart = block.timestamp;
    votingEnd = block.timestamp + (_durationInMinutes * 1 minutes);  //duration of voting
}

    modifier onlyOwner {
        require(msg.sender == owner);  //authority to ownwer
        _;
    }

    function addCandidate(string memory _name) public onlyOwner {
        candidates.push(Candidate({
                name: _name,
                voteCount: 0
        }));
    }

    function vote(uint256 _candidateIndex) public {
        require(!voters[msg.sender], "You have already voted.");
        require(_candidateIndex < candidates.length, "Invalid candidate index."); //wrong index out of bound

        candidates[_candidateIndex].voteCount++; //increase vote count
        voters[msg.sender] = true; //voter has voted and can not vote again
    }

    function getAllVotesOfCandiates() public view returns (Candidate[] memory){
        return candidates;
    }

    function getVotingStatus() public view returns (bool) {
        return (block.timestamp >= votingStart && block.timestamp < votingEnd);
    }

    function getRemainingTime() public view returns (uint256) {
        require(block.timestamp >= votingStart, "Voting has not started yet.");
        if (block.timestamp >= votingEnd) {
            return 0;
    }
        return votingEnd - block.timestamp;
    }
}
