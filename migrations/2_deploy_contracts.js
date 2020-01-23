var FPLEscrow = artifacts.require("FPLEscrow");

module.exports = function(deployer) {
  deployer.deploy(FPLEscrow);
};