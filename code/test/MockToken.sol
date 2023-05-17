// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "solmate/tokens/ERC20.sol";

contract MockToken is ERC20 {
    constructor() ERC20("test", "TT", 18) {
        _mint(msg.sender, 3 * 1e10 * 1e18);
    }

    function mint(uint256 amount) external {
        _mint(msg.sender, amount);
    }

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}
