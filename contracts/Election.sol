pragma solidity >=0.4.20;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    struct Voter {
        uint weight;
        bool voted;
    }

    // Store accounts that have voted
    mapping(address => Voter) public voters;
    // Store Candidates
    // Fetch Candidate
    mapping(uint => Candidate) public candidates;
    // Store Candidates Count
    uint public candidatesCount;
    address public chairperson;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

     event voterEvent (
        address indexed _voterId
    );

    constructor () public {
        chairperson = msg.sender;
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
        voters[msg.sender] = Voter(1, false);
        
    }
    

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }


    function vote (uint _candidateId) public {

        require(voters[msg.sender].weight ==1);

        // require that they haven't voted before
        require(!voters[msg.sender].voted);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender].voted = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }

    function giveVoteAccess (address _voterId) public  {

        require(msg.sender==chairperson, "Only admin can give accesss");
        //require(!voters[_voterId].voted, "Voter has already voted");
        //addCandidate("Candidate 3");
        // voters[0xd1F61F5522369767F938fd053D59eB28f07ceA97] = Voter(1, true);
        voters[_voterId] = Voter(1, false);
        emit voterEvent(_voterId);
      


    }
}
