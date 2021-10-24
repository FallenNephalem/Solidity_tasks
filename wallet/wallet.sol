pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Wallet {
    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    struct characterToken {
        string name;
        uint damage;
        uint defense;
        uint health;
    }

    characterToken[] tokensArray;
    mapping (uint => uint) tokenToOwner;
    mapping (uint => uint) tokensToSell;

    modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
		_;
	}

    modifier checkOwnerOfToken (uint tokenId){
        require(msg.pubkey() == tokenToOwner[tokenId], 101);
        tvm.accept();
        _;
    }
    function sendTransaction(address dest, uint128 value, bool bounce) public pure checkOwnerAndAccept {
        dest.transfer(value, bounce, 0);
    }

    function sendValueWithoutPayingFee(address dest, uint128 amount) public view checkOwnerAndAccept {
        dest.transfer(amount, true, 128);
    }
    function sendValueWithPayingFee(address dest, uint128 amount) public view checkOwnerAndAccept {
        dest.transfer(amount, true, 1);
    }
    function sendValueAndDeleteWallet(address dest, uint128 amount) public view checkOwnerAndAccept {
        dest.transfer(amount, false, 160);
    }

    // NFT logic
    function createToken(string name, uint damage, uint defense, uint health) public {
        tvm.accept();
        for (uint i = 0; i < tokensArray.length; i++) {
            require(name != tokensArray[i].name, 110);
        }

        tokensArray.push(characterToken(name, damage, defense, health));
        tokenToOwner[tokensArray.length - 1] = msg.pubkey();
    }
    function getTokenOwner(uint tokenId) public view returns (uint) {
        return tokenToOwner[tokenId];
    }
    
    function getTokenInfo(uint tokenId) public view returns (string characterName, uint characterDamage, uint characterDefense, uint characterHealth) {
        characterName = tokensArray[tokenId].name;
        characterDamage = tokensArray[tokenId].damage;
        characterDefense = tokensArray[tokenId].defense;
        characterHealth = tokensArray[tokenId].health;
    }

    function changeOwner(uint tokenId, uint pubKeyOfNewOwner) public checkOwnerOfToken(tokenId) {
        tokenToOwner[tokenId] = pubKeyOfNewOwner;
    }

    function getAllTokens() public view returns (characterToken[]) {
        return tokensArray;
    }

    function sendToSell(uint tokenId, uint price) public checkOwnerOfToken(tokenId){
        tokensToSell[tokenId] = price;
    }
}