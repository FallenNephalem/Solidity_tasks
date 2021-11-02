


pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "WarUnit.sol";

contract Warrior is WarUnit {
    constructor() public {
        require(msg.pubkey() == tvm.pubkey(), 103);
        tvm.accept();
        damage = 7;
        def = 5;
    }
}
