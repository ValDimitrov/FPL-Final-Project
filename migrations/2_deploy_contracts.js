var FPLEscrow = artifacts.require("FPLEscrow");
var SafeMath = artifacts.require("SafeMath");

module.exports = function(deployer) {
  deployer.deploy(SafeMath);
  deployer.link(SafeMath, FPLEscrow);
  deployer.deploy(FPLEscrow);
};