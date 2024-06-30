// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RetroListNFT is ERC721, Ownable {
    using Strings for uint256;

    // Base URL for metadata
    string private _baseTokenURI;
    uint256 public currentTokenId = 0;
    bool public mintEnabled = true;

    // Mapping from token ID to project ID
    mapping(uint256 => string) private _projectIds;

    constructor(
        string memory name,
        string memory symbol,
        string memory baseTokenURI
    ) Ownable(msg.sender) ERC721(name, symbol) {
        _baseTokenURI = baseTokenURI;
    }

    // Function to mint a new token
    event Mint(address indexed to, uint256 indexed tokenId, string projectId);
    function mint(
        address to,
        string memory projectId
    ) public onlyOwner {
        require(mintEnabled, "Mint Disabled");

        uint256 tokenId = ++currentTokenId;
        _mint(to, tokenId);
        _projectIds[tokenId] = projectId;
        emit Mint(to, tokenId, projectId);
    }

    event MintToggled(bool enabled);
    function toggleMint(bool enabled) public onlyOwner {
        mintEnabled = enabled;
        emit MintToggled(enabled);
    }

    // Override tokenURI to return the token URI based on project ID
    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        _requireOwned(tokenId);

        string memory projectId = _projectIds[tokenId];
        string memory baseURI = _baseURI();

        return
            bytes(baseURI).length > 0
                ? string.concat(
                    baseURI,
                    projectId,
                    ".json"
                )
                : "";
    }

    // Set a new base URI
    function setBaseURI(string memory baseTokenURI) public onlyOwner {
        _baseTokenURI = baseTokenURI;
    }

    // Return the base URI
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function totalSupply() external view returns (uint256) {
        return currentTokenId;
    }
}
