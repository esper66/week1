pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/comparators.circom";

template RangeProof(n) {
    assert(n <= 252);
    signal input in; // this is the number to be proved inside the range
    signal input range[2]; // the two elements should be the range, i.e. [lower bound, upper bound]
    signal output out;

    assert(range[0] < range[1]);

    component low = LessEqThan(n);
    component high = GreaterEqThan(n);
    component check = IsEqual();


    // [assignment] insert your code here
    // if in[0] <= in[1] return 1, this means lowerBound <= prooved num
    low.in[0] <== range[0];
    low.in[1] <== in;

    // if in[1] <= in[0] return 1, this means prooved num <= upperBound
    high.in[0] <== range[1];
    high.in[1] <== in;

    // if low.out==high.out return 1, this means Rangeproof is true. (low.out==high.out==0 pattern is impossible)
    check.in[0] <== low.out;
    check.in[1] <== high.out;

    out <== check.out;
}