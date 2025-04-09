// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {Calculator} from "../src/Calculator.sol";

contract CalculatorTest is Test {
    Calculator public calc;
    address public admin = vm.addr(1);
    address public otherUser = vm.addr(2);

    function setUp() public {
        calc = new Calculator(admin);
    }

    //UNIT TESTS
    function testAddition() public {
        uint256 number1_ = 2;
        uint256 number2_ = 3;
        uint256 result_ = calc.addition(number1_, number2_);
        assertEq(result_, number1_ + number2_, "Addition failed");
    }

    function testSubstraction() public {
        uint256 number1_ = 5;
        uint256 number2_ = 3;
        uint256 result_ = calc.substraction(number1_, number2_);
        assertEq(result_, number1_ - number2_, "Substraction failed");
    }

    function testMultiplier() public {
        vm.startPrank(admin);
        uint256 number1_ = 2;
        uint256 number2_ = 3;
        uint256 result_ = calc.multiplier(number1_, number2_);
        assertEq(result_, number1_ * number2_, "Multiplier failed");
        vm.stopPrank();
    }

    function testMultiplierNotAllowed() public {
        vm.startPrank(otherUser);
        uint256 number1_ = 100;
        uint256 number2_ = 10;
        vm.expectRevert("Not allowed - Only admin can call this function");
        calc.multiplier(number1_, number2_);
        vm.stopPrank();
    }

    function testDivision() public {
        vm.startPrank(admin);
        uint256 number1_ = 100;
        uint256 number2_ = 10;
        uint256 result_ = calc.division(number1_, number2_);
        assertEq(result_, number1_ / number2_, "Division failed");
        vm.stopPrank();
    }
    
    function testDivisionNotAllowed() public {
        vm.startPrank(otherUser);
        uint256 number1_ = 100;
        uint256 number2_ = 10;
        vm.expectRevert("Not allowed - Only admin can call this function");
        calc.division(number1_, number2_);
        vm.stopPrank();
    }

    function testDivisionCanNotbyZero() public {
        vm.startPrank(admin);
        uint256 number1_ = 2;
        uint256 number2_ = 0;
        vm.expectRevert("Division by zero is not allowed");
        calc.division(number1_, number2_);
        vm.stopPrank();
    }

    function testCount() public view {
        assertEq(calc.count(), 0, "Counter should be 0");
    }

    //FUZZING TESTS
    function testFuzzingAddition(uint256 number1_, uint256 number2_) public {
        // Prevent overflow in addition
        vm.assume(number2_ <= type(uint256).max - number1_);
        uint256 result_ = calc.addition(number1_, number2_);
        assertEq(result_, number1_ + number2_, "Addition failed");
    }

    function testFuzzingSubstraction(uint256 number1_, uint256 number2_) public {
        // Prevent underflow in subtraction
        vm.assume(number1_ >= number2_);
        uint256 result_ = calc.substraction(number1_, number2_);
        assertEq(result_, number1_ - number2_, "Substraction failed");
    }

    function testFuzzingMultiplier(uint256 number1_, uint256 number2_) public {
        vm.startPrank(admin);
        // Prevent overflow in multiplication
        vm.assume(number2_ <= type(uint256).max / number1_);
        uint256 result_ = calc.multiplier(number1_, number2_);
        assertEq(result_, number1_ * number2_, "Multiplier failed");
        vm.stopPrank();
    }

    function testFuzzingMultiplierNotAllowed(uint256 number1_, uint256 number2_) public {
        vm.startPrank(otherUser);
        vm.expectRevert("Not allowed - Only admin can call this function");
        calc.multiplier(number1_, number2_);
        vm.stopPrank();
    }

    function testFuzzingDivision(uint256 number1_, uint256 number2_) public {
        vm.startPrank(admin);
        // Avoid division by zero
        vm.assume(number2_ > 0);
        uint256 result_ = calc.division(number1_, number2_);
        assertEq(result_, number1_ / number2_, "Division failed");
        vm.stopPrank();
    }

    function testFuzzingDivisionNotAllowed(uint256 number1_, uint256 number2_) public {
        vm.startPrank(otherUser);
        vm.expectRevert("Not allowed - Only admin can call this function");
        calc.division(number1_, number2_);
        vm.stopPrank();
    }


    function testFuzzingCount(uint256 number1_, uint256 number2_) public {
        vm.startPrank(admin);
        // Avoid division by zero
        vm.assume(number2_ > 0);
        // Prevent underflow in subtraction
        vm.assume(number1_ >= number2_);
        // Prevent overflow in addition
        vm.assume(number2_ <= type(uint256).max - number1_);
        // Prevent overflow in multiplication
        vm.assume(number2_ <= type(uint256).max / number1_);


        calc.addition(number1_, number2_);
        calc.substraction(number1_, number2_);
        calc.division(number1_, number2_);
        calc.multiplier(number1_, number2_);
        calc.multiplier(number1_, number2_);
        assertEq(calc.count(), 5, "Counter should be 5");

        vm.stopPrank();
    }
}
