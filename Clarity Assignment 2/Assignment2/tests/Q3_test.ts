
import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.28.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
    name: "Ensure that <...>",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        let deployer = accounts.get('deployer')!;
        
        // Mine a block with one transaction.
        let block = chain.mineBlock([
            // Generate a contract call to count-up from the deployer address.
            Tx.contractCall('Q3', 'get-date', [types.uint(12345)], deployer.address)
        ]);

        assertEquals(block.receipts.length, 1);
        assertEquals(block.height, 2);

        let tuple = {
            hour: types.uint(3),
            min: types.uint(25),
            sec: types.uint(45)
        }

        assertEquals(block.receipts[0].result.expectOk().expectTuple(), tuple)
    },
});
