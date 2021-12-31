// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "./utils/ReverseTokenTest.sol";

contract ReverseContractTest is ReverseTokenTest {
    function testInitialQuote() public {
        // Path : REV => DAI
        address[] memory path = new address[](2);
        path[0] = address(reverseToken);
        path[1] = address(mockDAI);

        // The initial liquidity is : 1000 REV - 1000 DAI
        // The output for 1 REV must be around 1 DAI
        uint256[] memory amounts = router.getAmountsOut(1 ether, path);
        assertEq(amounts[1], getAmountOut(1 ether, 1000 ether, 1000 ether));
    }

    function testInitialPairBalance() public {
        assertEq(mockDAI.balanceOf(pair), 1000 ether);
        assertEq(reverseToken.balanceOf(pair), 1000 ether);
    }

    function testCannotSplitWithoutLP() public {
        hevm.expectRevert("EMPTY_LP");
        reverseToken.split(2, 1000 ether);
    }

    function testCannotSplitByOne() public {
        reverseToken.setLiquidityPool(pair);
        hevm.expectRevert("INCORRECT_DIVISOR");
        reverseToken.split(1, 1000 ether);
    }

    function testQuoteAfterSplit() public {
        reverseToken.setLiquidityPool(pair);

        // Path : REV => DAI
        address[] memory path = new address[](2);
        path[0] = address(reverseToken);
        path[1] = address(mockDAI);

        reverseToken.split(2, 1000 ether);

        assertEq(reverseToken.balanceOf(pair), 500 ether);

        // The liquidity is now (after split): 500 REV - 1000 DAI
        // The output for 1 REV must be around 2 DAI
        uint256[] memory amounts = router.getAmountsOut(1 ether, path);
        assertEq(amounts[1], getAmountOut(1 ether, 500 ether, 1000 ether));
    }
}
