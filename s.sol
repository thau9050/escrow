pragma solidity ^0.8.0;

contract Escrow {
  address payable public payer;
  address payable public payee;
  address public escrowAgent;
  uint public amount;

  constructor(address payable _payer, address payable _payee, uint _amount) {
    payer = _payer;
    payee = _payee;
    amount = _amount;
    escrowAgent = msg.sender;
  }

  function deposit() external payable {
    require(msg.sender == payer, "Only payer can deposit funds");
    require(msg.value == amount, "Deposit amount must match agreed upon amount");
  }

  function release() external {
    require(msg.sender == escrowAgent, "Only escrow agent can release funds");
    payable(payee).transfer(address(this).balance);
  }

  function cancel() external {
    require(msg.sender == escrowAgent, "Only escrow agent can cancel escrow");
    payable(payer).transfer(address(this).balance);
  }
}

