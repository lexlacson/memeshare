const main = async () => {
  const contractFactory = await hre.ethers.getContractFactory("MemeShare");
  const contract = await contractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.0001"),
  });
  await contract.deployed();

  console.log("contract address: ", contract.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();