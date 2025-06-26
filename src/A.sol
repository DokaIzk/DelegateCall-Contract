// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract A {
    uint256 public num;
    address public sender;
    uint256 public value;

    event DelegateResponse(bool success, bytes data);
    event CallResponse(bool success, bytes data);

    function setVarsCall(address _contract, uint256 _num) public payable {
        (bool success, bytes memory data) =
            _contract.call{value: msg.value}(abi.encodeWithSignature("setVars(uint256)", _num));

        emit CallResponse(success, data);
    }

    function setVarsDelegateCall(address _contract, uint256 _num) public payable {
        (bool success, bytes memory data) = _contract.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));

        emit DelegateResponse(success, data);
    }
}
