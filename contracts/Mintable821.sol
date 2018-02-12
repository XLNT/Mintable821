pragma solidity 0.4.19;

import 'zeppelin-solidity/contracts/ownership/rbac/RBAC.sol';
import './StandardAssetRegistry.sol';

contract Mintable821 is StandardAssetRegistry, RBAC {
  
  string constant ROLE_MINTER = "minter"; 
  bool minting;

  modifier onlyMinter() {
    require(
      hasRole(msg.sender, ROLE_MINTER)
    );
    _;
  }

  modifier canMint() {
    require(minting);
    _;
  }

  function Mintable821(address minter) public {
    _name = "Mintable821";
    _symbol = "MINT";
    _description = "ERC 821 minting contract";

    removeRole(msg.sender, ROLE_ADMIN);
    addRole(minter, ROLE_MINTER);

    minting = true;
  }

  function isContractProxy(address addr) public view returns (bool) {
    return _isContract(addr);
  }

  function generate(uint256 assetId, address beneficiary, string data) 
    onlyMinter
    canMint
    public
  {
    _generate(assetId, beneficiary, data);
  }

  // function update(uint256 assetId, string data)
  //   onlyMinter
  //   public 
  // {
  //   _update(assetId, data);
  // }

  function transferTo( 
    address to, uint256 assetId, bytes userData, bytes operatorData
  ) 
    public
  {
    return transfer(to, assetId, userData, operatorData);
  }

  function endMinting() 
    onlyMinter
    canMint
    public
  {
    minting = false;
  }
}
