// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Vault} from "../src/Vault.sol";
import {AddressSet, LibAddressSet} from "./utils/AddressSet.sol";

import {console} from "forge-std/console.sol";
import {CommonBase} from "forge-std/Base.sol";
import {StdUtils} from "forge-std/StdUtils.sol";

contract InvariantVault is CommonBase, StdUtils {
    // real contract
    Vault internal _underlying;

    // test actors
    using LibAddressSet for AddressSet;
    AddressSet internal _actors;
    address    internal _currentActor;

    // comparison variables
    uint public numDeposits;
    uint public totalDeposited;

    // automatically create actors
    modifier createActor() {
        _currentActor = msg.sender;  
        _actors.add(_currentActor);
        _;
    }

    constructor(Vault underlying) {
        _underlying = underlying;
    }

    // functions that expose _underlying with fuzz'd params
    function deposit(uint amount) public createActor {
        amount = bound(amount, 0.1 ether, 10 ether);
        vm.deal(_currentActor, amount);

        vm.prank(_currentActor);
        _underlying.deposit{value: amount}();

        numDeposits    += 1;
        totalDeposited += amount;
    }
}