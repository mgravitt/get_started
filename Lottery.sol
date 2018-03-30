pragma solidity ^0.4.21;

contract Lottery {
    address public manager;
    address[] public players;

    function Lottery () public {
        manager = msg.sender;
    }

    function enter () public payable {
        require (msg.value > 0.01 ether);
        players.push (msg.sender);
    }

    // select a psuedo-random number
    function random () private view returns (uint) {
        return uint(keccak256(block.difficulty, now, players));
    }

    function pickWinner () public {
        // only the manager should be allowed to call
        require (manager == msg.sender);

        uint index = random () % players.length;
        players[index].transfer (address(this).balance);

        // reset players so that the lottery can be run again
        players = new address[](0);
    }

    function getPlayers () public view returns (address[]) {
        return players;
    }
}
