// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/SO3Market.sol";
import "../src/SO3.sol";
import "../src/SO3Chef.sol";
import "../src/Vars.sol";
import "forge-std/Test.sol";
import "solmate/utils/CREATE3.sol";
import "./MockToken.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract MarketTest is Test {
    SO3Market public market;
    MockToken public so3;
    SO3Chef public chef;

    address treasury;
    address admin;

    function setUp() public {
        treasury = makeAddr("treasury");
        admin = makeAddr("admin");

        vm.startPrank(admin);
        so3 = new MockToken();

        chef = SO3Chef(
            address(
                new ERC1967Proxy(
                    address(new SO3Chef()),
                    abi.encodeWithSelector(
                        SO3Chef.initialize.selector,
                        so3,
                        address(0),
                        treasury,
                        1e18
                    )
                )
            )
        );

        market = SO3Market(
            address(
                new ERC1967Proxy(
                    address(new SO3Market()),
                    abi.encodeWithSelector(
                        SO3Market.initialize.selector,
                        treasury,
                        so3,
                        chef
                    )
                )
            )
        );

        chef.setAgent(address(market));

        vm.stopPrank();
    }

    function testMintWithBadAmount() public {
        vm.expectRevert(INVALID_MINT_PRICE.selector);
        market.buy{value: 0.011 ether}(makeAddr("alice"));
        vm.expectRevert(INVALID_MINT_PRICE.selector);
        market.buy{value: 0.009 ether}(makeAddr("alice"));
        vm.expectRevert(INVALID_MINT_PRICE.selector);
        market.buy{value: 0.0 ether}(makeAddr("alice"));
    }

    function testRepeatMint() public {
        address miner = makeAddr("one");
        market.buy{value: MINT_PRICE}(miner);

        vm.expectRevert(INVALID_BUY_PRICE.selector);

        market.buy{value: MINT_PRICE}(miner);
    }

    function testMintWithSC() public {
        address miner = address(this);
        vm.expectRevert(DISABLE_BUY_SELF.selector);

        market.buy{value: MINT_PRICE}(miner);

        vm.expectRevert(MINNER_MUSTBE_EOA.selector);
        market.buy{value: MINT_PRICE}(address(market));
    }

    function testMintNormal() public {
        address miner = makeAddr("MINER");
        market.buy{value: MINT_PRICE}(miner);

        (address owner_, uint256 worth, uint256 giff, uint256 vol, uint256 power) = market.minerInfo(miner);

        assertEq(owner_, address(this));
        assertEq(worth, 0.011 ether);
        assertEq(giff, 0);
        assertEq(vol, 0.01 ether);
        assertEq(power, market.getPower(vol, giff));
    }

    function testGrapWhenUseBadPrice() public {
        address miner = makeAddr("MINER");
        market.buy{value: MINT_PRICE}(miner);

        vm.expectRevert(INVALID_BUY_PRICE.selector);
        market.buy{value: 0.111 ether}(miner);
    }

    function testGrapWhenSelf() public {
        address miner = makeAddr("MINER");
        market.buy{value: MINT_PRICE}(miner);

        vm.expectRevert(INVALID_BUYER.selector);
        market.buy{value: 0.011 ether}(miner);
    }

    function testWhitelist() public {
        address miner = makeAddr("MINER");

        //whendisable
        vm.prank(admin);
        market.setWhitelistStatus(true);

        vm.expectRevert(MINSER_IS_NOT_IN_LIST.selector);
        market.buy{value: MINT_PRICE}(miner);

        // when open
        {
            vm.prank(admin);
            address[] memory list = new address[](1);
            list[0] = miner;
            market.setWhitelist(list, true);

            market.buy{value: MINT_PRICE}(miner);
        }

        //  when close
        {
            vm.prank(admin);
            address[] memory list = new address[](1);
            list[0] = miner;
            market.setWhitelist(list, false);

            hoax(admin, 0.11 ether);
            vm.expectRevert(MINSER_IS_NOT_IN_LIST.selector);
            market.buy{value: MINT_PRICE}(miner);
        }
    }

    function testGrapFine() public {
        address alice = makeAddr("alice");
        address bob = makeAddr("bob");
        address miner = makeAddr("MINER");
        hoax(bob, MINT_PRICE);
        market.buy{value: MINT_PRICE}(miner);

        uint256 bobBalance = bob.balance;
        uint256 minerBalance = miner.balance;
        uint256 treasuryBalance = treasury.balance + address(market).balance;

        hoax(alice, 0.011 ether);
        market.buy{value: 0.011 ether}(miner);

        // 0.011-0.0011-0.0022
        // 0.011 = 0.00011 + 0.00022 + 0.01067
        //  f1 2%= 0.011*2% =0.00022
        //  f2 1%= 0.011*1% =0.00011
        //    97%=  0.01067
        assertEq(minerBalance + 0.00011 ether, miner.balance);
        assertEq(treasuryBalance + 0.00022 ether, treasury.balance + address(market).balance);
        assertEq(bobBalance + 0.01067 ether, bob.balance);

        (address owner_, uint256 worth, uint256 giff, uint256 vol, uint256 power) = market.minerInfo(miner);

        assertEq(owner_, alice);
        assertEq(worth, 0.011 * 1.1 ether);
        assertEq(giff, 0);
        assertEq(vol, 0.01 ether + 0.011 ether);
        assertEq(power, market.getPower(vol, giff));
    }

    function testGrapWhenAttackMiner() public {
        address alice = makeAddr("alice");
        address bob = address(this);

        bytes32 salt = keccak256(bytes("1"));
        address miner = CREATE3.getDeployed(salt);

        market.buy{value: MINT_PRICE}(miner);

        //deploy minner
        CREATE3.deploy(salt, type(AttackMiner).creationCode, 0);

        uint256 bobBalance = bob.balance;
        uint256 treasuryBalance = treasury.balance + address(market).balance;

        hoax(alice, 0.011 ether);
        market.buy{value: 0.011 ether}(miner);

        // 0.011-0.0011-0.0022
        // 0.011 = 0.00011 + 0.00022 + 0.01067
        //  f1 2%= 0.011*2% =0.00022
        //  f2 1%= 0.011*1% =0.00011
        //    97%=  0.01067
        assertEq(treasuryBalance + 0.00022 ether + 0.00011 ether, treasury.balance + address(market).balance);
        assertEq(bobBalance + 0.01067 ether, bob.balance);
    }

    function testGrapWhenAttackOwner() public {
        address alice = makeAddr("alice");
        address bob = address(new AttackOwner());

        address miner = makeAddr("minner");

        hoax(bob, 0.01 ether);
        market.buy{value: MINT_PRICE}(miner);

        uint256 bobBalance = bob.balance;
        uint256 treasuryBalance = treasury.balance + address(market).balance;
        uint256 minerBalance = miner.balance;

        hoax(alice, 0.011 ether);
        market.buy{value: 0.011 ether}(miner);

        assertEq(minerBalance + 0.00011 ether, miner.balance);
        assertEq(treasuryBalance + 0.00022 ether + 0.01067 ether, treasury.balance + address(market).balance);
        assertEq(bobBalance + 0 ether, bob.balance);
    }

    function testGrapWhenAttackAll() public {
        address alice = makeAddr("alice");
        address bob = address(new AttackOwner());
        bytes32 salt = keccak256(bytes("2"));

        address miner = CREATE3.getDeployed(salt);

        hoax(bob, 0.01 ether);
        market.buy{value: MINT_PRICE}(miner);

        //deploy minner
        CREATE3.deploy(salt, type(AttackMiner).creationCode, 0);

        uint256 bobBalance = bob.balance;
        uint256 treasuryBalance = treasury.balance + address(market).balance;
        uint256 minerBalance = miner.balance;

        hoax(alice, 0.011 ether);
        market.buy{value: 0.011 ether}(miner);

        assertEq(minerBalance + 0 ether, miner.balance);
        assertEq(treasuryBalance + 0.011 ether, treasury.balance + address(market).balance);
        assertEq(bobBalance + 0 ether, bob.balance);
    }

    function testLikeWhenZero() public {
        address miner = makeAddr("MINER");
        market.buy{value: MINT_PRICE}(miner);

        market.like(miner, 0, "");

        (,, uint256 giff,,) = market.minerInfo(miner);
        assertEq(giff, 0);
    }

    function testLikeWithPermit() public {
        address miner = makeAddr("MINER");
        market.buy{value: MINT_PRICE}(miner);

        likeMiner("alice", miner, 1e18, 0);
        likeMiner("alice", miner, 1999 * 1e18, 0);
        likeMiner("alice", miner, 0, 0);
        likeMiner("alice", miner, 1, 0);
    }

    function testLikeWhenOverflow() public {
        address miner = makeAddr("MINER");
        market.buy{value: MINT_PRICE}(miner);

        likeMiner("alice", miner, type(uint128).max, 0);

        likeMiner("alice", miner, 1, CAST_TO_128_OVERFLOW.selector);
    }

    function testAdminWhenSetTreasury() public {
        address addr = makeAddr("newAdmin");
        vm.expectRevert("Ownable: caller is not the owner");
        market.setTreasury(addr);

        vm.prank(admin);
        market.setTreasury(addr);
        assertEq(addr, market.treasury());
    }

    function testAdminWhenSetFeeBP() public {
        vm.expectRevert("Ownable: caller is not the owner");
        market.setFeeBP(1, 2);

        vm.prank(admin);
        market.setFeeBP(1, 2);
        assertEq(1, market.tradeFeeToTreasuryBP());
        assertEq(2, market.tradeFeeToMinerBP());
    }

    function testAdminWhenSetChef() public {
        address addr = makeAddr("chef");
        vm.expectRevert("Ownable: caller is not the owner");

        market.setChef(IChef(addr));

        vm.prank(admin);
        market.setChef(IChef(addr));
        assertEq(addr, address(market.so3Chef()));
    }

    // function testAdmin() public {
    //     checkOwnerCall(
    //         abi.encodeWithSelector(market.setTreasury.selector, makeAddr("new"))
    //     );
    //     checkOwnerCall(abi.encodeWithSelector(market.setChef.selector));
    //     checkOwnerCall(abi.encodeWithSelector(market.setEthCap.selector));
    //     checkOwnerCall(abi.encodeWithSelector(market.setFeeBP.selector));
    // }

    // function checkOwnerCall(bytes memory data) internal {
    //     (bool success, bytes memory ret) = address(market).call(data);
    //     assertFalse(success);
    //     console2.logBytes(ret);
    // }

    function likeMiner(string memory who, address miner, uint256 giff, bytes4 errCode) internal {
        (address alice, uint256 pkey) = makeAddrAndKey(who);

        uint256 amount = giff * 100 * 1e18;
        bytes memory data = makeSO3PermitCallData(pkey, address(market), amount, block.timestamp, so3.nonces(alice));

        changePrank(alice);
        so3.mint(amount);

        uint256 so3Balance = so3.balanceOf(alice);

        (,, uint256 giff1,, uint256 power1) = market.minerInfo(miner);

        changePrank(alice);
        if (errCode > 0) {
            vm.expectRevert(errCode);
        }
        market.like(miner, giff, data);
        vm.stopPrank();

        if (errCode == 0) {
            (,, uint256 giff2,, uint256 power2) = market.minerInfo(miner);
            assertEq(giff2 - giff1, giff);
            assertEq(power2 - power1, giff);
            assertEq(so3Balance - so3.balanceOf(alice), amount);
        }
    }

    function makeSO3PermitCallData(uint256 privateKey, address spender, uint256 value, uint256 deadline, uint256 nonce)
        public
        returns (bytes memory)
    {
        address owner = vm.addr(privateKey);
        bytes32 hash = makeSO3PermintHash(owner, spender, value, deadline, nonce);

        vm.startPrank(owner);
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

    receive() external payable {}
}

contract AttackMiner {
    receive() external payable {
        revert("REJ");
    }
}

contract AttackOwner {
    receive() external payable {
        revert("REJ");
    }
}
