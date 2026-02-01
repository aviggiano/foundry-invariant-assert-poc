// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {BeforeAfter} from "./BeforeAfter.sol";

abstract contract Properties is BeforeAfter, Asserts {
    function invariant_number_is_small() public returns (bool) {
        lt(counter.number(), 42, "invariant_number_is_small");
        return true;
    }

    function invariant_noop() public returns (bool) {
        // no-op
        return true;
    }
}
