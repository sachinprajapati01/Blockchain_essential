 // SPDX-License-Identifier: GPL-3.0
 pragma solidity >=0.5.3 > 0.8.3;

contract bank{
    
    //variable Declarations 
    address owner;
    mapping(address => uint256) accountHoldersBalance;    // 2d array or simply a map
    address[] accountHolders;
    
    constructor(){
        owner = msg.sender;
    }
    
    function openAccount() payable public{
        require(msg.value >= 1 ether, "Requires One Ether Minimum"); \\Minimum value for account opening
        accountHoldersBalance[msg.sender] = msg.value;
        accountHolders.push(msg.sender);
        
    }
    
    function deposit() payable public{
        require(msg.value >= 1 wei, "Requires 1 wei Minimum");   \\ minimum value for deposit
        accountHoldersBalance[msg.sender] = accountHoldersBalance[msg.sender] + msg.value;
        
    }
    
    function checkbalance() public view returns(uint256){
        return accountHoldersBalance[msg.sender];
    }
    
    function withdraw(uint256 withdrawMoney) payable public{
        require(accountHoldersBalance[msg.sender] >= withdrawMoney, "Required Money is not there!!");
        accountHoldersBalance[msg.sender] = accountHoldersBalance[msg.sender] - withdrawMoney;
        address payable transferAccount = payable(msg.sender);
        transferAccount.transfer(withdrawMoney);
    }
    
    
    function captialOfBank() public view returns(uint256){
      require(msg.sender == owner, " Required to be owner");   //customer can not see 
      return( address(this).balance);
    }
    
}
