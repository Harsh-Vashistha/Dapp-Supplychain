const HDWalletProvider=require('@truffle/hdwallet-provider');
const infuraKey="6741bd65e9ef41fbb8cc76b45b2d5350";
const fs=require("fs");
const memonic=fs.readFileSync('./.secret').toString().trim();


module.exports={
  networks:{
    development:{
      host:"127.0.0.1",
      port:8545,
      network_id:"*"//match any network id
    },
    ropsten: {
      provider: new HDWalletProvider(
        memonic, "wss://ropsten.infura.io/ws/v3/6741bd65e9ef41fbb8cc76b45b2d5350", 0
        ),
      network_id: 3,
      gas: 4700000,
      gasPrice: 100000000000
    }
  },
  solc:{
    optimizer:{
      enabled:true,
      runs:200
    }
  }
}