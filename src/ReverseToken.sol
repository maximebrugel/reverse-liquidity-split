// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "solmate/auth/Trust.sol";
import "solmate/tokens/ERC20.sol";
import "v2-core/interfaces/IUniswapV2Pair.sol";

contract ReverseToken is ERC20("Reverse Token", "REV", 18), Trust(msg.sender) {
    address public liquidityPool;

    function split(uint256 divisor, uint256 minAmount) external requiresTrust {
        require(liquidityPool != address(0), "EMPTY_LP");
        require(divisor > 1, "INCORRECT_DIVISOR");

        uint256 liqAmount = balanceOf[liquidityPool];
        require(liqAmount >= minAmount, "SLIPPAGE_ERROR");

        _burn(liquidityPool, liqAmount / divisor);

        IUniswapV2Pair(liquidityPool).sync();
    }

    function setLiquidityPool(address _liquidityPool) external requiresTrust {
        require(liquidityPool == address(0), "IMMUTABLE_LP");
        liquidityPool = _liquidityPool;
    }
}
