require("@nomicfoundation/hardhat-toolbox");
require("@openzeppelin/hardhat-upgrades");


const LOCAL = {
  RPC_URL: "http://127.0.0.1:8545",
  PRIVATE_KEY_LIST: ["22a440a5d53fe20f381f3dc36c0b8531be93011ab412ca4ca94b530c6d680b9c"], // 0x9cc4669bb997c40579f89E08980B99218abaE3FE
}

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  networks: {
    local: {
        url: LOCAL.RPC_URL, 
        accounts: LOCAL.PRIVATE_KEY_LIST,
    }
},
  solidity: "0.8.24",
};
