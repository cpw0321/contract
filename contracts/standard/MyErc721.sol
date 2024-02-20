// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract MyERC721 is ERC721, AccessControl{

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    bytes32 public constant METADATA_ROLE = keccak256("METADATA_ROLE");

    string private _baseTokenURI;
    uint256 public currentTokenId = 0;

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(MINTER_ROLE, msg.sender);
        _setupRole(BURNER_ROLE, msg.sender);
        _setupRole(METADATA_ROLE, msg.sender);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function setBaseURI(string calldata newBaseTokenURI) public onlyRole(METADATA_ROLE) {
        _baseTokenURI = newBaseTokenURI;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function baseURI() public view returns (string memory) {
        return _baseURI();
    }

    function exists(uint256 tokenId) public view returns (bool) {
        return _exists(tokenId);
    }

    function mint(address to, uint256 tokenId) public onlyRole(MINTER_ROLE) {
        _safeMint(to, tokenId);
    }

    function mint(address to) public onlyRole(MINTER_ROLE) {
        currentTokenId = SafeMath.add(currentTokenId, 1);
        _safeMint(to, currentTokenId);
    }

    function transferFrom(address from, address to, uint256 tokenId) public onlyRole(MINTER_ROLE) {
        _transfer(from, to, tokenId);
    }

    function burn(uint256 tokenId) public onlyRole(BURNER_ROLE) {
        _burn(tokenId);
    }
}