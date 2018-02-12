# Mintable821
A mintable ERC821 Token

## To Run
Install packages

```
npm install
```

Start a local blockchain like [Ganache](https://github.com/trufflesuite/ganache). You can use [Ganache CLI](https://github.com/trufflesuite/ganache-cli) or the [desktop client](http://truffleframework.com/ganache/). Make sure it is running on port 8545.

```
ganache-cli
```

In 2_deploy_contract.js change the second argument of the deployer function to the address that will mint the tokens.

```
deployer.deploy(Mintable821, "0xsomeaddresshere");
```

Compile and migrate your local smart contracts.

```
truffle migrate --reset
```

Run Tests

```
truffle test
```
