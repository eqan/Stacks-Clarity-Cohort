
import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.28.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
    name: "Ensure that <...>",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        let deployer = accounts.get('deployer')!;
        
        // Mine a block with one transaction.
        let block = chain.mineBlock([
            // Generate a contract call to count-up from the deployer address.
            Tx.contractCall('Q2', 'no-leap', [types.uint(1972), types.uint(2020)], deployer.address),
            Tx.contractCall('Q2', 'no-leap', [types.uint(2000), types.uint(2016)], deployer.address)
        ]);

        let receipts = block.receipts;
        receipts[0].result.expectOk().expectUint(13);
        receipts[1].result.expectOk().expectUint(5);
    },
});
