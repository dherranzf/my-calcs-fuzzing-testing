// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.28;

contract Calculator {

    //VARIABLES
    address public admin;
    uint256 public count;

    //EVENTS
    event Addition(uint256 indexed number1_, uint256 indexed number2_, uint256 indexed result_);
    event Substraction(uint256 indexed number1_, uint256 indexed number2_, uint256 indexed result_);
    event Multiplier(uint256 indexed number1_, uint256 indexed number2_, uint256 indexed result_);
    event Division(uint256 indexed number1_, uint256 indexed number2_, uint256 indexed result_);

    //MODIFIERS
    modifier onlyAdmin() {
        require(msg.sender == admin, "Not allowed - Only admin can call this function");
        _;
    }

    constructor(address admin_) {
        admin = admin_;
    }

    //FUNCTIONS
    function addition(uint256 number1_, uint256 number2_) external returns(uint256 result_){
        count++;
        result_ = number1_ + number2_;
        emit Addition(number1_, number2_, result_);
    }

    function substraction(uint256 number1_, uint256 number2_) external returns(uint256 result_){
        count++;
        result_ = number1_ - number2_;
        emit Substraction(number1_, number2_, result_);
    }

    function multiplier(uint256 number1_, uint256 number2_) external onlyAdmin returns(uint256 result_){
        count++;
        result_ = number1_ * number2_;
        emit Multiplier(number1_, number2_, result_);
    }

    function division(uint256 number1_, uint256 number2_) external onlyAdmin returns(uint256 result_){
        count++;
        require(number2_ != 0, "Division by zero is not allowed");
        result_ = number1_ / number2_;
        emit Division(number1_, number2_, result_);
    }

}
