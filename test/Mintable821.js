require('babel-polyfill');

require('chai')
  .use(require('chai-as-promised'))
  .should();

const Mintable821 = artifacts.require('Mintable821.sol');

contract('Mintable821', function (accounts) {
  beforeEach(async function () {
    this.mintable = await Mintable821.new(accounts[1]);
  });

  it('cannot mint a token from an account that is not the minter', async function () {
    await this.mintable.generate(1,accounts[0],"some data",{from: accounts[0]}).should.be.rejected;
  });

  it('can mint a token from the minter account', async function () {
    await this.mintable.generate(1,accounts[0],"some data",{from: accounts[1]}).should.be.fulfilled;
  });

  it('cannot mint after Minting has ended (only callable by minter)', async function () {
    await this.mintable.endMinting({from:accounts[0]}).should.be.rejected;
    await this.mintable.endMinting({from:accounts[1]}).should.be.fulfilled;
    await this.mintable.generate(2,accounts[0],"some more data",{from: accounts[1]}).should.be.rejected;
  });
});
