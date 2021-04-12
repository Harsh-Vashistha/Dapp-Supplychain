const Chain = artifacts.require("../contracts/Chain.sol");

module.exports = function (deployer) {
  deployer.deploy(Chain);
};
