import { config as dotenv } from "dotenv"
dotenv()

import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const PRIVATE_KEY: string = process.env.PRIVATE_KEY!
const ETHERSCAN_API_KEY: string = process.env.ETHERSCAN_API_KEY!

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.24", // any version you want
    settings: {
      viaIR: true,
      optimizer: {
        enabled: true,
        details: {
          yulDetails: {
            optimizerSteps: "u",
          },
        },
      },
    },
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://bscscan.com/
    apiKey: ETHERSCAN_API_KEY,
  },
  networks: {
    optimism_testnet: {
      url: "https://goerli.optimism.io",
      chainId: 420,
      accounts: [ PRIVATE_KEY ]
    },
    optimism_mainnet: {
      url: "https://mainnet.optimism.io",
      chainId: 10,
      accounts: [ PRIVATE_KEY ]
    },
    base_mainnet: {
      url: "https://mainnet.base.org",
      chainId: 8453,
      accounts: [ PRIVATE_KEY ]
    },
  }
};

export default config;
