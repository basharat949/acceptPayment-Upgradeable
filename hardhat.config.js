require("dotenv").config();
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");
// require("hardhat-gas-reporter");
// require('solidity-coverage');
const { GOERLI_API_URL, API_URL, PRIVATE_KEY, ETHERSCAN_API_KEY } = process.env;
module.exports = {
        solidity: "0.8.17",
        defaultNetwork: "hardhat",
        networks: {
            hardhat: {},
             bsctestnet: {
               url: "https://data-seed-prebsc-1-s1.binance.org:8545",
               chainId: 97,
               accounts: [process.env.PRIVATE_KEY],
             },
             polygon_mumbai: {
              url: API_URL,
              accounts: [`0x${PRIVATE_KEY}`]
           },
            goerli: {
            url: GOERLI_API_URL,
            accounts: [process.env.PRIVATE_KEY],
          }
        },
        etherscan: {
           apiKey: ETHERSCAN_API_KEY,
        }
};