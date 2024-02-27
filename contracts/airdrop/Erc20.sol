// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

interface IToken {
    function mint(address to, uint256 amount) external;
    function transfer(address to, uint256 amount) external;
    function burn(address from, uint256 amount) external;
}

contract MyERC20 is AccessControl {
    bytes32 public constant Airdrop_ROLE = keccak256("Airdrop_ROLE");

    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(Airdrop_ROLE, msg.sender);
    }

    function batchMint(
        address tokenAddress,
        address[] memory toAccounts,
        uint256[] memory amounts
    ) external onlyRole(Airdrop_ROLE) {
        require(toAccounts.length == amounts.length, "parameter is invalid");
        for (uint256 i = 0; i < toAccounts.length; i++) {
            uint256 amount = amounts[i];
            if (amount > 0) {
                IToken(tokenAddress).mint(toAccounts[i], amounts[i]);
            }
        }
    }

    function batchTransfer(
        address tokenAddress,
        address[] memory toAccounts,
        uint256[] memory amounts
    ) external onlyRole(Airdrop_ROLE) {
        require(toAccounts.length == amounts.length, "parameter is invalid");
        for (uint256 i = 0; i < toAccounts.length; i++) {
            uint256 amount = amounts[i];
            if (amount > 0) {
                IToken(tokenAddress).transfer(toAccounts[i], amounts[i]);
            }
        }
    }

    function batchBurn(
        address tokenAddress,
        address[] memory fromAccounts,
        uint256[] memory amounts
    ) external onlyRole(Airdrop_ROLE) {
        require(fromAccounts.length == amounts.length, "parameter is invalid");
        for (uint256 i = 0; i < fromAccounts.length; i++) {
            uint256 amount = amounts[i];
            if (amount > 0) {
                IToken(tokenAddress).burn(fromAccounts[i], amounts[i]);
            }
        }
    }
}
