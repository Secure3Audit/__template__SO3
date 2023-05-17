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
    SO3 public so3;
    SO3Chef public chef;

    address treasury;
    address admin;
    address alice = makeAddr("alice");
    address bob = makeAddr("bob");
    address eva = makeAddr("eva");

    function setUp() public {
        treasury = makeAddr("treasury");
        admin = makeAddr("admin");

        vm.startPrank(admin);
        so3 = new SO3();

        chef = SO3Chef(
            address(
                new ERC1967Proxy(
                    address(new SO3Chef()),
                    abi.encodeWithSelector(
                        SO3Chef.initialize.selector,
                        IMintPool(address(so3)),
                        address(0),
                        treasury,
                        10 * 1e18
                    )
                )
            )
        );
        chef.setFeeBP(100, 200);
        chef.setAgent(address(this));
        so3.setMaster(address(chef));

        vm.stopPrank();
    }

    function testDepoist() external {
        chef.deposit(alice, alice, 1000);
        chef.deposit(alice, alice, 2000);
        chef.deposit(alice, alice, 3000);
        chef.deposit(alice, alice, 0);

        (, uint256 amount,,) = chef.userInfo(alice);
        assertEq(amount, 6000);
    }

    function testDepoistWhenBadCaller() external {
        vm.startPrank(makeAddr("badCaller"));

        vm.expectRevert(INVALID_CHEF_AGENT.selector);
        chef.deposit(alice, alice, 1000);
    }

    function testRewardNoraml() public {
        address minerAlice = makeAddr("MINER_ALICE");
        address minerBob = makeAddr("MINER_BOB");
        address[] memory minerList = new address[](2);
        minerList[0] = minerAlice;
        minerList[1] = minerBob;

        vm.prank(admin);
        chef.setRewardPerBlock(10 * 1e18);

        chef.deposit(minerAlice, alice, 1000);
        chef.deposit(minerBob, bob, 3000);

        vm.warp(block.timestamp + 3); // 3 seconds later
        chef.claim(); //for sync

        // 1/4
        assertEq(chef.unclaimed(minerAlice), ((3 * 10 * 1e18) * 1) / 4);
        // 3/4
        assertEq(chef.unclaimed(minerBob), ((3 * 10 * 1e18) * 3) / 4);

        chef.deposit(minerAlice, alice, 2000);

        assertEq(chef.unclaimed(minerAlice), ((3 * 10 * 1e18) * 1) / 4);
        assertEq(chef.unclaimed(minerBob), ((3 * 10 * 1e18) * 3) / 4);

        {
            vm.warp(block.timestamp + 6); // 6 seconds later
            chef.claim(); //for sync

            assertEq(
                chef.unclaimed(minerAlice),
                ((3 * 10 * 1e18) * 1) / 4 + ((6 * 10 * 1e18) * 2) / 4 //3.75e19
            );
            assertEq(
                chef.unclaimed(minerBob),
                ((3 * 10 * 1e18) * 3) / 4 + ((6 * 10 * 1e18) * 2) / 4 //=5.25e19
            );
        }

        //claim
        address alice2 = makeAddr("alice2");
        {
            chef.setHost(minerAlice, alice2);

            vm.prank(minerAlice);
            chef.claim();
            vm.prank(minerBob);
            chef.claim();

            assertEq(so3.balanceOf(alice2), 3.75e19 * 0.97);
            assertEq(so3.balanceOf(bob), 5.25e19 * 0.97);
        }

        {
            // alice=3000,bob=5000
            chef.deposit(minerBob, bob, 2000);

            vm.warp(block.timestamp + 10); // 10 seconds later

            vm.prank(minerBob);
            chef.claim();

            assertEq(so3.balanceOf(bob), (5.25e19 + ((10 * 10 * 5000) / 8000) * 1e18) * 0.97);
        }
        chef.claim(minerList);

        assertEq(so3.totalSupply(), (3 + 6 + 10) * 10 * 1e18);

        assertEq(chef.totalDeposits(), 8000);

        //after reset
        vm.warp(block.timestamp + 2); // 2 seconds later
        vm.prank(admin);
        chef.setRewardPerBlock(20 * 1e18);

        chef.deposit(minerAlice, alice2, 2000);
        chef.deposit(minerBob, bob, 2000);

        vm.warp(block.timestamp + 4); // 4 seconds later

        chef.claim(minerList);

        assertEq(
            so3.totalSupply(),
            289999999999999999999 //(3 + 6 + 10 + 2) * 10 * 1e18 + 4 * 20 * 1e18
        );
    }

    function testRewardMax(uint256 amount) public {
        vm.assume(amount > 0 && amount < 40 * 1e9 * 1e18);

        chef.deposit(alice, alice, amount);

        vm.prank(admin);
        chef.setRewardPerBlock(1.29481651e20);

        vm.warp(block.timestamp + 365 days);
        vm.prank(alice);
        chef.claim();

        assertEq(1.29481651e20 * 365 days * 0.98 - so3.balanceOf(alice) < 1e18, true);
    }

    // 0.04 ETH
    function test100Miners() public {
        address[] memory list = new address[](100);
        for (uint256 i = 0; i < 100; i++) {
            chef.deposit(address(uint160(i)), alice, 1000);
            list[i] = address(uint160(i));
        }
        vm.roll(block.number + 20);
        chef.claim(list);

        vm.roll(block.number + 20);
        chef.claim(list);
    }
}
