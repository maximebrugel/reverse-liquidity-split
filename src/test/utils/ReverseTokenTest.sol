// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "./Hevm.sol";
import "ds-test/test.sol";
import "../mocks/MockDAI.sol";
import "../../ReverseToken.sol";
import "v2-core/interfaces/IUniswapV2Factory.sol";
import "v2-periphery/interfaces/IUniswapV2Router02.sol";

abstract contract ReverseTokenTest is DSTest {
    Hevm internal constant hevm = Hevm(HEVM_ADDRESS);
    IUniswapV2Router02 internal constant router =
        IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
    IUniswapV2Factory internal constant factory =
        IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);

    address internal pair;
    ReverseToken internal reverseToken;
    MockDAI internal mockDAI;
    address internal alice;

    function setUp() public {
        reverseToken = new ReverseToken();
        mockDAI = new MockDAI();

        mockDAI.mint(address(this), 1000 ether);
        reverseToken.mint(address(this), 1000 ether);

        mockDAI.approve(address(router), type(uint256).max);
        reverseToken.approve(address(router), type(uint256).max);

        router.addLiquidity(
            address(reverseToken),
            address(mockDAI),
            1000 ether,
            1000 ether,
            0,
            0,
            address(this),
            block.timestamp
        );

        pair = factory.getPair(address(reverseToken), address(mockDAI));

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
