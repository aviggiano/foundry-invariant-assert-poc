// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {BeforeAfter} from "./BeforeAfter.sol";

abstract contract Properties is BeforeAfter, Asserts {

  function invariant_number_is_big() public returns (bool) {
    gt(counter.number(), type(uint256).max/2, "Number should be big");
    return counter.number() > type(uint256).max/2;
  }

  function assert_number_is_always_42() public {
    eq(counter.number(), 42, "Number is always 42");
    counter.increment();
  }
}