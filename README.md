# MemeShare

I created a basic web3 app using a [Buildspace tutorial](https://buildspace.so/p/build-solidity-web3-app). Instead of creating a Wave Portal and I created a Meme Portal to share memes and add them to the blockchain. This repo contains the smart contract. This is what the react app looks like that connects to the smart contract:

![app2](https://github.com/lexlacson/memeshare/blob/main/app2.png)
![app](https://github.com/lexlacson/memeshare/blob/main/app.png)


# Development

This is a hardhat project.

Some test commands:
```shell
npx hardhat run scripts/run.js
npx hardhat run scripts/deploy.js --network rinkeby
```

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```
