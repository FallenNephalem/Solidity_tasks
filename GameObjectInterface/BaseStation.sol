

pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "GameObject.sol";

contract BaseStation is GameObject {
    address station_address = msg.sender;
    address[] units;
    function get_adress() public returns (address){
        tvm.accept();
        return station_address;
    }
    function addWarUnit(address unit_addr) public {
        require(msg.pubkey() == tvm.pubkey(), 100);
        require(tvm.pubkey() != 0, 110);
		tvm.accept();
        units.push(unit_addr);
    }
    function removeWarUnit(address unit_addr) public {
        for (uint i = 0; i<units.length; i++) {
            if (units[i] == unit_addr) {
                delete units[i];
            }
        }
    }
    function die() public override {
        for (uint i = 0; i<units.length; i++) {
            sendAllandDestroy(units[i]);
        }
        sendAllandDestroy(station_address);
    }
}
