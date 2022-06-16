//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFT is ERC721URIStorage {
    uint private _tokenIds;
    address payable owner;
    uint price;

    constructor(uint _price) ERC721("MyNFT", "NFT") {
        owner = payable(msg.sender);
        price = _price;
    }

    function mintNFT(string memory tokenURI)
        public
        payable
        returns (uint256)
    {
        require(msg.value >= price, "You don't have enough funds");
        owner.transfer(msg.value);
        _tokenIds = _tokenIds + 1;
        _mint(msg.sender, _tokenIds);
        _setTokenURI(_tokenIds, tokenURI);

        return _tokenIds;
    }
}
