# foundry-bug-report-4808
minimal test case for foundry bug report 4804

forge test -vvv

Run it a few times, it will sometimes pass, but in some runs it will get to a point and set the Vault's balance to the amount to msg.value instead of incrementing the balance. If running with -vvv the last output from failed execution will look like:

  actor          :  0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
  amount         :  10000000000000000000
  balance        :  10000000000000000000
  depositCount   :  10
  totalDeposited :  63397231504052652563
  Error: a == b not satisfied [uint]
        Left: 10000000000000000000
       Right: 63397231504052652563

You can see that storage variables depositCount & totalDeposited continued to be incremented, but the contract's balance was set to msg.value instead of being incremented, which made that invariant fail.
