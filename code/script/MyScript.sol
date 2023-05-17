// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import "../src/SO3Market.sol";
import "../src/SO3.sol";

contract MyScript is Script {
    SO3 so3 = SO3(0xA0a121C77a3317Cf31B14b5a3089C2DAc70b5c3B);

    function run() external {
        uint256 pkey = vm.envUint("RAW_PRIVATE_KEY");

        uint256 giff = 2;
        SO3Market market = SO3Market(0xF3c6B66b2E85fEb494Ac2ce9D8013dC82614473D);
        address miner = 0x1003ff39d25F2Ab16dBCc18EcE05a9B6154f65F4;
        address owner = vm.addr(pkey);
        bytes memory data = makeSO3PermitCallData(
            pkey, address(market), giff * 100 * 1e18, block.timestamp + 20 minutes, so3.nonces(owner)
        );

        vm.startBroadcast(pkey);
        market.like(miner, giff, data);
        vm.stopBroadcast();
    }

    function makeSO3PermitCallData(uint256 privateKey, address spender, uint256 value, uint256 deadline, uint256 nonce)
        public
        returns (bytes memory)
    {
        address owner = vm.addr(privateKey);
        bytes32 hash = makeSO3PermintHash(owner, spender, value, deadline, nonce);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, hash);

        return abi.encode(owner, spender, value, deadline, v, r, s);
    }

    function makeSO3PermintHash(address owner, address spender, uint256 value, uint256 deadline, uint256 nonce)
        public
        view
        returns (bytes32)
    {
        return keccak256(
            abi.encodePacked(
                "\x19\x01",
                so3.DOMAIN_SEPARATOR(),
                keccak256(
                    abi.encode(
                        keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
                        owner,
                        spender,
                        value,
                        nonce,
                        deadline
                    )
                )
            )
        );
    }
}
