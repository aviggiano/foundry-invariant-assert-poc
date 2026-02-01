// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {FoundryAsserts} from "@chimera/FoundryAsserts.sol";

import "forge-std/console2.sol";

import {Test} from "forge-std/Test.sol";
import {TargetFunctions} from "./TargetFunctions.sol";

// forge test --match-contract CryticToFoundry -vv
contract CryticToFoundry is Test, TargetFunctions, FoundryAsserts {
    bool internal shouldFail;
    string internal lastAssertionReason;

    function setUp() public {
        setup();

        targetContract(address(this));
        targetSender(address(0x10000));
        targetSender(address(0x20000));
        targetSender(address(0x30000));
    }

    function invariant_no_assertion_failures() public {
        assertTrue(!shouldFail, lastAssertionReason);
    }

    function isAssertion(string memory reason) internal pure returns (bool) {
        return keccak256(abi.encodePacked(reason)) == keccak256(abi.encodePacked("ASSERTION"));
    }

    function _recordFailure(string memory reason) internal {
        shouldFail = true;
        lastAssertionReason = reason;
    }

    function gt(uint256 a, uint256 b, string memory reason) internal virtual override(Asserts, FoundryAsserts) {
        if (a <= b) {
            if (isAssertion(reason)) {
                _recordFailure(reason);
            } else {
                super.gt(a, b, reason);
            }
        }
    }

    function gte(uint256 a, uint256 b, string memory reason) internal virtual override(Asserts, FoundryAsserts) {
        if (a < b) {
            if (isAssertion(reason)) {
                _recordFailure(reason);
            } else {
                super.gte(a, b, reason);
            }
        }
    }

    function lt(uint256 a, uint256 b, string memory reason) internal virtual override(Asserts, FoundryAsserts) {
        if (a >= b) {
            if (isAssertion(reason)) {
                _recordFailure(reason);
            } else {
                super.lt(a, b, reason);
            }
        }
    }

    function lte(uint256 a, uint256 b, string memory reason) internal virtual override(Asserts, FoundryAsserts) {
        if (a > b) {
            if (isAssertion(reason)) {
                _recordFailure(reason);
            } else {
                super.lte(a, b, reason);
            }
        }
    }

    function eq(uint256 a, uint256 b, string memory reason) internal virtual override(Asserts, FoundryAsserts) {
        if (a != b) {
            if (isAssertion(reason)) {
                _recordFailure(reason);
            } else {
                super.eq(a, b, reason);
            }
        }
    }

    function t(bool b, string memory reason) internal virtual override(Asserts, FoundryAsserts) {
        if (!b) {
            if (isAssertion(reason)) {
                _recordFailure(reason);
            } else {
                super.t(b, reason);
            }
        }
    }
}
