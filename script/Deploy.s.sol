// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import {TrustedOracle} from "../src/TrustedOracle.sol";
import {IBlockhashStorage} from "../src/interfaces/IBlockhashStorage.sol";
import {TransactionInclusionProver} from "../src/TransactionInclusionProver.sol";
import {ERC20RewardForProof} from "../src/ERC20RewardForProof.sol";
import {BatchTrustedOracle} from "../src/BatchTrustedOracle.sol";
 
contract DeployScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PK");
        vm.startBroadcast(deployerPrivateKey);

        IBlockhashStorage blockhashStorage = new BatchTrustedOracle();
        TransactionInclusionProver prover = new TransactionInclusionProver(
            address(blockhashStorage)
        );

        ERC20RewardForProof rewardForProof = new ERC20RewardForProof( address(prover),
        1000000000000000000, "ETHPARIS Test", "EPT");


        vm.stopBroadcast();
    }
}
