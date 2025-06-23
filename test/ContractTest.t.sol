// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {A} from "../src/A.sol";
import {B} from "../src/B.sol";

contract TestContract is Test {
    A public contractA; 
    B public contractB;
    address public user;
    uint8 constant DECIMALS = 18;

    function setUp() public {
        contractA = new A();
        contractB = new B();
        user = address(0x123);

        vm.deal(user, 5 * (10 ** DECIMALS));
    }

    function test_setVarsCall() public {
        vm.prank(user);
        contractA.setVarsCall{value: 2 * (10 ** DECIMALS)}(address(contractB), 20);

        assertEq(contractA.num(), 0);
        assertEq(contractA.sender(), address(0));
        assertEq(contractA.value(), 0);

        assertEq(contractB.num(), 20);
        assertEq(contractB.sender(), address(contractA));
        assertEq(contractB.value(), 2 * (10 ** DECIMALS));
    }

    function test_setVarsDelegateCall() public {
        vm.prank(user);
        contractA.setVarsDelegateCall{value: 2 * (10 ** DECIMALS)}(address(contractB), 99);

        assertEq(contractA.num(), 99);
        assertEq(contractA.sender(), user);
        assertEq(contractA.value(), 2 * (10 ** DECIMALS));

        assertEq(contractB.num(), 0);
        assertEq(contractB.sender(), address(0));
        assertEq(contractB.value(), 0);
    }
}