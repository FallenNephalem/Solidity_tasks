

pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "GameObject.sol";
import "BaseStation.sol";


contract WarUnit is GameObject {
    uint damage = 0;
    address station_address;
    constructor(address station_addr) public {
        require(msg.pubkey() == tvm.pubkey(), 103);
        tvm.accept();
        // hp = unit_hp;
        // def = unit_def;
        station_address = station_addr;
        BaseStation(station_addr).addWarUnit(msg.sender);
    }
    function attack(GameObject def_unit) public {
        tvm.accept();
        def_unit.takeAttack(damage);
    }
    function getAttackPower(uint dam) public {
        tvm.accept();
        damage = dam;
    }
    function die() public override {
        BaseStation(station_address).removeWarUnit(msg.sender);
        sendAllandDestroy(msg.sender);
    }
}
