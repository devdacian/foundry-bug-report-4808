# foundry-bug-report-4808
minimal test case for foundry bug report 4804

forge test -vvv

Run it a few times some runs will pass, but other runs will fail as at a seemingly-random point, the Vault's balance gets set to msg.value instead of being incrementing. If running with -vvv the last output from failed execution will look like:

        actor          :  0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
        amount         :  10000000000000000000
        balance        :  10000000000000000000
        depositCount   :  10
        totalDeposited :  63397231504052652563
        Error: a == b not satisfied [uint]
        Left : 10000000000000000000
        Right: 63397231504052652563

You can see that storage variables depositCount & totalDeposited continued to be incremented, but the contract's balance was set to msg.value instead of being incremented, which made invariant_addrBalance_eq_totalDeposited fail.
