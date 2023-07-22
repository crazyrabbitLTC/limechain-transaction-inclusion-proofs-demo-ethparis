// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "./interfaces/IBlockhashStorage.sol";

/**
 * @title TrustedOracle contract
 * @notice The contract provides an example of a trusted oracle used for crosschecking block hashes
 * @dev The conctract is owned by an address that can set block hashes
 * @author LimeChain
 */
contract BatchTrustedOracle is IBlockhashStorage, Ownable {
    mapping(uint256 => bytes32) private _blockHashes;

    /// @notice Sets the block hashes for given block numbers
    /// @dev Only the contract owner can call this function
    /// @param blockNumbers The array of block numbers for which to set the block hashes
    /// @param blockHashes The array of block hashes to set
    function setBlockHashes(
        uint256[] memory blockNumbers,
        bytes32[] memory blockHashes
    ) public {
        require(
            blockNumbers.length == blockHashes.length,
            "blockNumbers and blockHashes must have the same length"
        );

        for (uint i = 0; i < blockNumbers.length; i++) {
            _blockHashes[blockNumbers[i]] = blockHashes[i];
        }
    }

    /// @notice Sets the block hash for a given block number
    /// @dev Only the contract owner can call this function
    /// @param blockNumber The block number for which to set the block hash
    /// @param blockHash The block hash to set
    function setBlockHash(
        uint256 blockNumber,
        bytes32 blockHash
    ) public {
        _blockHashes[blockNumber] = blockHash;
    }

    /// @notice Gets the block hash for a given block number
    /// @param blockNumber The block number for which to get the block hash
    /// @return The block hash for the given block number
    function getBlockHash(uint256 blockNumber) public view returns (bytes32) {
        return _blockHashes[blockNumber];
    }
}
