pragma solidity ^0.8.8;

import "../lib/forge-std/src/Script.sol";
import "../lib/forge-std/src/console2.sol";

import "../contracts/PNft.sol";

contract DeployNft is Script {
    function setUp() public {}

    function run() public {
        address myAccount = 0xFaBcc4b22fFEa25D01AC23c5d225D7B27CB1B6B8;
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        uint pvk = vm.envUint("PRIVATE_KEY2");
        address acc = vm.addr(privateKey);
        console.log("Account", acc);
        vm.startBroadcast(privateKey);
        PNft nfts = new PNft();
        console.log(address(nfts));
        nfts.safeMint(acc);
    }
}

//forge script scripts/DeployNft.s.sol:DeployNft --rpc-url https://eth-sepolia.public.blastapi.io --broadcast -vvv --legacy --slow
//forge script scripts/DeployNft.s.sol:DeployNft --rpc-url  https://node.botanixlabs.dev --broadcast -vvv --legacy --slow
