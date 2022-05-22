import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.28.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
    name: "Ensure that <...>",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        let deployer = accounts.get('deployer')!;
        
        // Mine a block with one transaction.
        let block = chain.mineBlock([
            // Generate a contract call to count-up from the deployer address.
            Tx.contractCall('Q1', 'is-leap', [types.uint(1972)], deployer.address),
            Tx.contractCall('Q1', 'is-leap', [types.uint(2022)], deployer.address)
        ]);

        // Get the first (and only) transaction receipt.
        // for (let i = 0; i < receipts.length; i++) {
            // Assert that the returned result is a boolean true.
        //   }
        let receipts = block.receipts;
        receipts[0].result.expectOk().expectBool(true);
        receipts[1].result.expectOk().expectBool(false);
    },
});
