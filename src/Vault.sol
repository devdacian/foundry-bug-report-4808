// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {console} from "forge-std/console.sol";

contract Vault {

    uint public depositCount;
    uint public totalDeposited;
    constructor() {}

    function deposit() external payable {
        depositCount   += 1;
        totalDeposited += msg.value;

        console.log("actor          : ", msg.sender);
        console.log("amount         : ", msg.value);
        console.log("balance        : ", address(this).balance);
        console.log("depositCount   : ", depositCount);
        console.log("totalDeposited : ", totalDeposited);
    }

}