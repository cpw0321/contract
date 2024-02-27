const { ethers, upgrades } = require("hardhat");

const myERC721Addr = "0x70193C1B3Af838cCa4CeC0FDe8E2544a632b806e"
async function main(){
    // npx hardhat run --network local scripts/standard/mint-myerc721.js

    const myERC721 = await ethers.getContractFactory("MyERC721");
    const instance = await myERC721.attach(myERC721Addr)
    let uri = "https://ipfs.io/ipfs/QmXeypeQzWsbiBbeo7vKuGvaRvrp9j6NGcsPWegZmW8XXy/metadata/"
    const res = await instance.setBaseURI(uri);
    console.log("status:", res);

    let toAddress = '0x22220a7C9510cd94e7cAE9CD569dE40C8B195567';
    for (let i = 1; i < 3; i++) {
        let tokenId = i;
        const tx = await instance.mint(toAddress, tokenId);
        const res = await tx.wait(1);
        console.log("status:", res.status);
    }

    let tokenURI1 = await instance.tokenURI(1);
    console.log("tokenURI:", tokenURI1)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });