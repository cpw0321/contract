const { ethers, upgrades } = require("hardhat");

// myERC721: 0x49246b1c6eE78881720515c155C4c25ac9F80099
async function main(){
    // npx hardhat run --network local scripts/standard/deploy-myerc721.js

    const myERC721 = await ethers.getContractFactory("MyERC721");
    const instance = await upgrades.deployProxy(myERC721, ["test05", "test05"]);
    await instance.waitForDeployment();
    console.log("myERC721:", instance.target);

    // upgrades
    // upgrades.upgradeProxy(instance.address, myERC721);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });