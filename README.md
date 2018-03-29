# Jump Start with Ethereum and React

### Developed for NYC Blockchain Hack - 2018-03-31

[Atom Text Editor](https://atom.io) (Or other text editor of your choice)
[Node.js](https://nodejs.org/en/)
[MetaMask](https://metamask.io/)
[with test ether](https://faucet.rinkeby.io/)
[Heroku](https://heroku.com)

### Steps

#### Author Smart Contract in Remix

Go to http://remix.ethereum.org

Paste code for Lottery Contract

```
pragma solidity ^0.4.21;

contract Lottery {
    address public manager;
    address[] public players;

    function Lottery () public {
        manager = msg.sender;
    }

    function enter () public payable {

        // emphasize the use of "ether" keyword
        require (msg.value > 0.01 ether);

        // emphasize 'payable' function type
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
```
