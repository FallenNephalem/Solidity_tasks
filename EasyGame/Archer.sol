


pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "WarUnit.sol";

contract Archer is WarUnit {
    constructor() public {
        require(msg.pubkey() == tvm.pubkey(), 103);
        tvm.accept();
        damage = 5;
        def = 3;
    }
}
