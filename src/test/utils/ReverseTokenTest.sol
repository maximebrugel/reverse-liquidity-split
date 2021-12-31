// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "./Hevm.sol";
import "ds-test/test.sol";
import "../mocks/MockDAI.sol";
import "../../ReverseToken.sol";


abstract contract ReverseTokenTest is DSTest {
    Hevm internal constant hevm = Hevm(HEVM_ADDRESS);
    address internal constant router = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

    ReverseToken internal reverseToken;
    MockDAI internal mockDAI;
    address internal alice;

    function setUp() public virtual {
        reverseToken = new ReverseToken();
        mockDAI = new MockDAI();

        reverseToken.mint(address(this), 1000 ether);
        mockDAI.mint(address(this), 1000 ether);

        // TODO add liquidity

        alice = generateAddress("alice");
        reverseToken.mint(alice, 1000 ether);
        mockDAI.mint(alice, 1000 ether);
    }

    function generateAddress(bytes memory seed)
        internal
        pure
        returns (address)
    {
        return address(bytes20(uint160(uint256(keccak256(seed)))));
    }
}
