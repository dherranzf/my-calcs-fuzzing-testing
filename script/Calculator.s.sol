// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.28;

import {Script, console} from "forge-std/Script.sol";
import {Calculator} from "../src/Calculator.sol";

contract CalculatorScript is Script {
    Calculator public calculator;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        address admin = msg.sender;
        calculator = new Calculator(admin);

        vm.stopBroadcast();
    }
}
