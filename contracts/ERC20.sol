// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ERC20 {
  uint256 public totalSupply;
  string public name;
  string public symbol;

  // mapping(address => uint256) private balances;

  // function balanceOf(address owner) public view returns(uint256) {
  //   return balances[owner];
  // }

  // To Transfer token behalf of someoneelse we need transferFrom and approve function

  mapping(address => uint256) public balanceOf;

  mapping(address => mapping(address=> uint256)) public allowance;

  // function balanceOf(address owner, address spender) public view returns(uint256) {
  //   return allowance[owner][spender];
  // }

  // we need this mapping to know store which owner address have approve how many funds for which spender addresses
  // we need tokenTransfer
  constructor(string memory _name, string memory _symbol) {
    name = _name;
    symbol = _symbol;

    _mint(msg.sender, 100e18); //100,000,000,000
  }

  function decimals() external pure returns (uint8) {
    return 18;
  }

  //recipient -> where the caller want to transfer his funds to?

  // function transfer(address recipient, uint256 amount) external returns (bool){
  //   require(recipient!= address(0), "ERC20 transfer to the zero address");

  //   // this will automatically calc asd hash of msg.sender address to look up balance value in storge
  //   uint256 senderBalance = balanceOf[msg.sender];

  //   require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");

  //   balanceOf[msg.sender] = senderBalance - amount;

  //   balanceOf[recipient] += amount;

  //   return true;
  // }

  function transfer(address recipient, uint256 amount) external returns (bool){
    return _transfer(msg.sender, recipient, amount);
  }

  function tranferFrom(address sender, address recipient, uint256 amount) external returns (bool){
    
    // before transfer we need to check if the function caller is allowed to make this transfer
    // we can retrive the allowed value by looking in allowance mapping
    // sender and spender(msg.sender)
    uint256 currentAllowance = allowance[sender][msg.sender];

    require(
      currentAllowance >= amount,
      "ERC20: transfer amount exceeds allowance");

    allowance[sender][msg.sender] = currentAllowance - amount;

    return _transfer(sender, recipient, amount);
  }


  // owner to allow other address to spend the token on their behalf
  function approve(address spender, uint256 amount) external returns(bool) {
     require(
      spender != address(0),
      "ERC20: approve to the zero address");

     allowance[msg.sender][spender] = amount;

     return true;
  }

  function _transfer(address sender, address recipient, uint256 amount) private returns (bool){
    require(recipient!= address(0), "ERC20 transfer to the zero address");

    // this will automatically calc asd hash of msg.sender address to look up balance value in storge
    uint256 senderBalance = balanceOf[sender];

    require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");

    balanceOf[sender] = senderBalance - amount;

    balanceOf[recipient] += amount;

    return true;
  }

  function _mint(address to, uint256 amount) internal{
    require(to != address(0), "ERC20: Mint to the zero address");

    totalSupply += amount;

    balanceOf[to] += amount;
  }

}
