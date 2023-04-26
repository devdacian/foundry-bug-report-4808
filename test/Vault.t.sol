// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Vault} from "../src/Vault.sol";
import {InvariantVault} from "./InvariantVault.sol";

import {StdInvariant} from "forge-std/StdInvariant.sol";
import {Test} from "forge-std/Test.sol";

contract VaultTest is StdInvariant, Test {
    // real contract
    Vault          internal _underlying;
    // handler which exposes real contract
    InvariantVault internal _handler;

    function setUp() public {
        _underlying = new Vault();
        _handler = new InvariantVault(_underlying);

        // invariant fuzz targets _handler contract
        targetContract(address(_handler));

        // functions to target during invariant tests
        bytes4[] memory selectors = new bytes4[](1);
        selectors[0] = _handler.deposit.selector;

        targetSelector(FuzzSelector({
            addr: address(_handler),
            selectors: selectors
        }));
    }

    // invariant: number of deposits
    function invariant_depositCount_eq_numDeposits() public {
        assertEq(_underlying.depositCount(), _handler.numDeposits());
    }

    // invariant: total amount deposited matched via variable
    function invariant_totalDeposited_eq_totalDeposited() public {
        assertEq(_underlying.totalDeposited(), _handler.totalDeposited());
    }

    // invariant: total amount deposited matched via account balance - fails
    function invariant_addrBalance_eq_totalDeposited() public {
        assertEq(address(_underlying).balance, _handler.totalDeposited());
    }
}