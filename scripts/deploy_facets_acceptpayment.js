async function main() {
    const AcceptPayments = await ethers.getContractFactory("AcceptPayments");
    const deployedAcceptPayments = await AcceptPayments.deploy();
    await deployedAcceptPayments.deployed();
    console.log("Accept Payment facets deployed to: ", deployedAcceptPayments.address);
  }
  main();