// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

abstract contract Hevm {
    // Sets the block timestamp to x
    function warp(uint256 x) public virtual;

    // Sets the block number to x
    function roll(uint256 x) public virtual;

    // Sets the slot loc of contract c to val
    function store(
        address c,
        bytes32 loc,
        bytes32 val
    ) public virtual;

    // Reads the slot loc of contract c
    function load(address c, bytes32 loc) public virtual returns (bytes32 val);

    // Signs the digest using the private key sk.
    // Note that signatures produced via hevm.sign will leak the private key.
    function sign(uint256 sk, bytes32 digest)
        public
        virtual
        returns (
            uint8 v,
            bytes32 r,
            bytes32 s
        );

    // Derives an ethereum address from the private key sk.
    // Note that hevm.addr(0) will fail with BadCheatCode as 0 is an invalid ECDSA private key
    function addr(uint256 sk) public virtual returns (address addr);

    // Executes the arguments as a command in the system shell and returns stdout.
    // Note that this cheatcode means test authors can execute arbitrary code on user machines
    // as part of a call to dapp test, for this reason all calls to ffi will fail unless the --ffi
    // flag is passed.
    function ffi(string[] calldata) public virtual returns (bytes memory);

    // Sets an account's balance
    function deal(address who, uint256 amount) public virtual;

    // Sets the contract code at some address contract code
    function etch(address where, bytes memory what) public virtual;

    // Performs the next smart contract call as another address
    // (prank just changes msg.sender. Tx still occurs as normal)
    function prank(address from) public virtual;

    // Performs smart contract calls as another address. The account impersonation lasts until the end
    // of the transaction, or until stopPrank is called.
    function startPrank(address from) public virtual;

    // Stop calling smart contracts with the address set at startPrank
    function stopPrank() public virtual;

    // Tells the evm to expect that the next call reverts with specified error bytes.
    function expectRevert(bytes calldata expectedError) public virtual;

    // Set block.basefee (newBasefee)
    function fee(uint256) public virtual;

    // Record all storage reads and writes
    function record() public virtual;

    // Gets all accessed reads and write slot from a recording session, for a given address
    function accesses(address)
        public
        virtual
        returns (bytes32[] memory reads, bytes32[] memory writes);
}
