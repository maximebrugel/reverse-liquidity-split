// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "solmate/tokens/ERC20.sol";

contract MockDAI is ERC20("DAI Stablecoin", "DAI", 18) {
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}
