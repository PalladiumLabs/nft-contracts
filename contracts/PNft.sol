// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PNft is ERC721, Ownable {
    uint256 private _tokenIdCounter;
    bool public pauseStatus = false;

    mapping(address => uint) nftID;

    constructor() ERC721("Circuit Breaker Genesis", "Palladium-SBT-1") {}

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override {
        require(from == address(0), "Token not transferable");
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function safeMint(address to) public {
        require(pauseStatus == false, "Mint is Paused");
        require(balanceOf(to) == 0, "You already have an nft");
        _tokenIdCounter += 1;
        _safeMint(to, _tokenIdCounter);
        nftID[to] = _tokenIdCounter;
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721) {
        super._burn(tokenId);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721) returns (string memory) {
        return
            "https://gateway.pinata.cloud/ipfs/QmZh8ceaSM1Y65VPpGsTSKSrxYPiF6zfK5uJqxrntqAaDg";
    }

    function pause() public onlyOwner {
        pauseStatus = true;
    }

    function unPause() public onlyOwner {
        pauseStatus = false;
    }

    function idOf(address _user) public view returns (uint256) {
        return nftID[_user];
    }
}
