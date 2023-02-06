// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract VendingMachine {
    //amount here is amount of the one to purchase
    address public owner;
    mapping(address => uint) public donutBalances;
    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can restock the machine");
        _;
    }

    constructor() {
        owner = msg.sender;
        donutBalances[address(this)] = 100;
    }

    function getVendingMachineBalance() public view returns (uint) {
        return donutBalances[address(this)];
    }

    function restock(uint amount) public onlyOwner {
        donutBalances[address(this)] += amount;
    }

    function purchase(uint amount) public payable {
        require(
            msg.value >= amount * 2 ether,
            "you must pay atleast 2 ethers "
        );
        require(
            donutBalances[address(this)] >= amount,
            "not enought donuts in stock to fulfill request"
        );
        donutBalances[address(this)] -= amount;
        donutBalances[msg.sender] += amount;
    }
}

//after deploy the contract on the ganache cli  by uncomment the development code in truffle-config
//after deployed try the contract in trffle console by creataing the instances
//
//know try to deploy the contract on the ethereum testnet goerli eth
// we need metamask
//  2. infura - which help to connect to blockchain wihtout installing in to the personal computer makeing out computer a node
// by just creating the api key we can connet our contract to the blockchain
//
