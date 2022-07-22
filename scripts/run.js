const main = async () => {
  const contractFactory = await hre.ethers.getContractFactory("MemeShare");
  const contract = await contractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.0001"),
  });
  await contract.deployed();
  console.log("Contract addy:", contract.address);

  let contractBalance = await hre.ethers.provider.getBalance(
    contract.address
  );
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  let memeCount;
  memeCount = await contract.getTotalMemes();
  console.log(memeCount.toNumber());

  let memeTxn = await contract.meme("A message!");
  await memeTxn.wait();
  memeTxn = await contract.meme("B message!");
  await memeTxn.wait();
  memeTxn = await contract.meme("C message");
  await memeTxn.wait();

  memeCount = await contract.getTotalMemes();

  const [_, randomPerson] = await hre.ethers.getSigners();
  memeTxn = await contract.connect(randomPerson).meme("Another message!");

  contractBalance = await hre.ethers.provider.getBalance(contract.address);
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  let allMemes = await contract.getAllMemes();
  console.log(allMemes);
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