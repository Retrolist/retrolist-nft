import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const MyNFT = await ethers.getContractFactory("RetroListNFT");
  const myNFT = await MyNFT.deploy("RetroList Retro Funding 4", "RETRO4", "https://round4.retrolist.app/metadata/nft/");

  console.log("RetroListNFT deployed to:", await myNFT.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
      console.error(error);
      process.exit(1);
  });