async function main() {
  const AtlatenDiamondProxy = await ethers.getContractFactory("AtlatenDiamondProxy");
  const atlatenDiamondProxy = await AtlatenDiamondProxy.deploy();
  await atlatenDiamondProxy.deployed();
  console.log("Atlaten Diamond Proxy deployed to: ", atlatenDiamondProxy.address);
}
main();