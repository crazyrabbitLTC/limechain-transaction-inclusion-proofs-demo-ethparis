// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./TransactionInclusionProver.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ERC20RewardForProof {

    TransactionInclusionProver private _prover;
    IERC20 private _token;
    uint256 private _tokensToSend;

    constructor(
        address proverAddress,
        address tokenAddress,
        uint256 tokensToSend
    ) {
        _prover = TransactionInclusionProver(proverAddress);
        _token = IERC20(tokenAddress);
        _tokensToSend = tokensToSend;
    }

    function sendTokens(ProverDto calldata data) external {
        bool isIncluded = _prover.proveTransactionInclusion(data);

        require(isIncluded, "Transaction not included in the block!");

        require(
            _token.balanceOf(address(this)) >= _tokensToSend,
            "Not enough tokens in the contract to reward!"
        );

        require(
            _token.transfer(msg.sender, _tokensToSend),
            "Failed to transfer tokens to sender!"
        );
    }
}
