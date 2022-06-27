// SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ERC20 {
  uint256 public totalSupply;
  string public name;
  string public symbol;

  // mapping(address => uint256) private balances;

  // function balanceOf(address owner) public view returns(uint256) {
  //   return balances[owner];
  // }

  mapping(address => uint256) public balanceOf;


  constructor(string memory _name, string memory _symbol) {
    name = _name;
    symbol = _symbol;
  }

  function decimals() external pure returns (uint8) {
    return 18;
  }

  //recipient -> where the caller want to transfer his funds to?
  
  function transfer(address recipient, uint256 amount) external returns (bool){
    require(recipient!= address(0), "ERC20 transfer to the zero address");

    // this will automatically calc asd hash of msg.sender address to look up balance value in storge
    uint256 senderBalance = balanceOf[msg.sender];

    require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");

    balanceOf[msg.sender] = senderBalance - amount;

    balanceOf[recipient] += amount;

    return true;
  }


}
