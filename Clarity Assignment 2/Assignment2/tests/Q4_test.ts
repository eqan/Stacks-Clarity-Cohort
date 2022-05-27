
import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.28.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
    name: "Ensure that <...>",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        let deployer = accounts.get('deployer')!;
        let block = chain.mineBlock([
            Tx.contractCall('Q4', 'get-missing', [types.list([1, 2, 3, 4, 6, 7, 8, 9, 10])], deployer.address),
            Tx.contractCall('Q4', 'get-missing', [types.list([1, 3, 4, 5, 6, 7, 8, 9, 10])], deployer.address)
        ]);
        let receipts = block.receipts;
        receipts[0].result.expectOk().expectInt(5);
        receipts[1].result.expectOk().expectInt(2);
    },
});