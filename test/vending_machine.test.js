const VendingMachine = artifacts.require("VendingMachine");

contract("VendingMachine", (accounts) => {
  before(async () => {
    instance = await VendingMachine.deployed();
  });
  it("ensures that the starting balance  of the vending machine ", async () => {
    let balance = await instance.getVendingMachineBalance();
    assert.equal(balance, 100, "the initial balance should be 100 donots");
  });
  it("ensure that the vending machine is resotck", async () => {
    await instance.restock(100);
    let balance = await instance.getVendingMachineBalance();
    console.log(balance);
    assert.equal(balance, 200, "the update balance");
  });
  it("purchase donuts", async () => {
    await instance.purchase(1, {
      from: accounts[0],
      value: web3.utils.toWei("3", "ether"),
    });
    let balance = await instance.getVendingMachineBalance();
    // console.log(balance);
    assert.equal(balance, 199, "the update balance");
  });
});
