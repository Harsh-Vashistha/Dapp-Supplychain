module.exports={
  networks:{
    develpoment:{
      host:"127.0.0.1",
      port:7545,
      network_id:"*"//match any network id
    }
  },
  solc:{
    optimizer:{
      enabled:true,
      runs:200
    }
  }
}