

pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "GameObject.sol";

contract WarUnit is GameObject{
    int public damage = 0;

    function attack(GameObject def_unit) public{
        tvm.accept();
        def_unit.takeAttack(damage);
    }
    function getAttackPower(int dam) public {
        tvm.accept();
        damage = dam;
    }
    function getHealth() public returns (int){
        tvm.accept();
        return hp;
    }
    function getInfo() public returns (int[]){
        tvm.accept();
        return [hp, def, damage];
    }
}
