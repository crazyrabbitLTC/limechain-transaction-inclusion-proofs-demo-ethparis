// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./TransactionInclusionProver.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract ERC20RewardForProof is ERC20 {

    TransactionInclusionProver private _prover;
    uint256 private _rewardAmount;

    constructor(
        address proverAddress,
        uint256 rewardAmount,
        string memory name,
        string memory symbol
    ) ERC20(name, symbol) {
        _prover = TransactionInclusionProver(proverAddress);
        _rewardAmount = rewardAmount;
    }

    function claimReward(ProverDto calldata inclusionProof) external {
        bool isIncluded = _prover.proveTransactionInclusion(inclusionProof);

        require(isIncluded, "Transaction not included in the block!");

        _mint(msg.sender, _rewardAmount);
    }
}

