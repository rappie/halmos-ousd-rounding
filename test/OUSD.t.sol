// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/token/OUSD.sol";

contract DeployTest is OUSD, Test {
    address public VAULT = address(0x10000);
    address public FROM = address(0x20000);
    address public TO = address(0x30000);

    function setUp() public {
        InitializableERC20Detailed._initialize("OUSD", "OUSD", 18);
        _rebasingCreditsPerToken = 1e18;
        vaultAddress = VAULT;
    }

    // function testOUSDStatic() public payable {
    //     // uint amount = 0x00000000000000000000000000000000a021f6670f959fb44812137232dfdf2e;
    //     // uint amount = 212852822760004585532822399203286179630;
    //     uint256 amount = 211987165329378596875806276197710037552;

    //     mint(FROM, amount);

    //     // uint256 fromBalanceBefore = balanceOf(FROM);
    //     uint256 toBalanceBefore = balanceOf(TO);

    //     _executeTransfer(FROM, TO, amount);

    //     // uint fromBalanceAfter = balanceOf(FROM);
    //     uint256 toBalanceAfter = balanceOf(TO);

    //     console.log("toBalanceBefore", toBalanceBefore);
    //     console.log("toBalanceAfter", toBalanceAfter);
    //     console.log("amount", amount);

    //     assert(toBalanceAfter == toBalanceBefore + amount);
    //     // assert(fromBalanceAfter == fromBalanceBefore - amount);
    // }

    function testOUSD(
        uint256 amount
    ) public payable {
        vm.assume(amount <= MAX_SUPPLY);

        mint(FROM, amount);

        // uint256 fromBalanceBefore = balanceOf(FROM);
        uint256 toBalanceBefore = balanceOf(TO);

        _executeTransfer(FROM, TO, amount);

        // uint fromBalanceAfter = balanceOf(FROM);
        uint toBalanceAfter = balanceOf(TO);

        assert(toBalanceAfter == toBalanceBefore + amount);
        // assert(fromBalanceAfter == fromBalanceBefore - amount);
    }
}
