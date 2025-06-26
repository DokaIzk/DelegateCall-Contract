// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {A} from "../src/A.sol";
import {B} from "../src/B.sol";

contract DeployAndRun is Script {
    function run() external {
        vm.startBroadcast();

        B b = new B();
        A a = new A();

        console.log("Contract A deployed at:", address(a));
        console.log("Contract B deployed at:", address(b));

        a.setVarsCall{value: 0.01 ether}(address(b), 20);

        a.setVarsDelegateCall{value: 0.01 ether}(address(b), 99);

        console.log("=== Contract A ===");
        console.log("A.num():", a.num());
        console.log("A.sender():", a.sender());
        console.log("A.value():", a.value());

        console.log("=== Contract B ===");
        console.log("B.num():", b.num());
        console.log("B.sender():", b.sender());
        console.log("B.value():", b.value());

        vm.stopBroadcast();
    }
}
