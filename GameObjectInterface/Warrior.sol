
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "WarUnit.sol";

contract Warrior is WarUnit {
    constructor(address station_addr) WarUnit(station_addr) public {
        require(msg.pubkey() == tvm.pubkey(), 103);
        tvm.accept();
        damage = 5;
        def = 7;
    }
    function getInfo() public returns (uint[]){
        tvm.accept();
        return [hp, def, damage];
    }
}
