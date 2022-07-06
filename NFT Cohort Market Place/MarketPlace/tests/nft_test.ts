import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.31.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
    name: "Ensure that minting is working!",
    async fn(chain: Chain, accounts: Map<string, Account>) {

        const deployer = accounts.get("deployer")!;
        const wallet2 = accounts.get("wallet_1")!;

        let block = chain.mineBlock([
           
           Tx.contractCall("nft", "mint!", [types.uint(200), types.some(types.ascii("ummar.jpeg"))], deployer.address)
          
        ]);

        assertEquals(block.receipts.length, 1);
        assertEquals(block.height, 2);
        
        block.receipts[0].result.expectOk()
        .expectAscii("Success")

        
        block.receipts[0].events.expectNonFungibleTokenMintEvent(types.uint(1), deployer.address, 
        `${deployer.address}.nft`, "cohort-art")

    },
});

Clarinet.test({
    name: "Ensure that owner is correct!",
    async fn(chain: Chain, accounts: Map<string, Account>) {

        const deployer = accounts.get("deployer")!;
        const wallet2 = accounts.get("wallet_1")!;

        let block = chain.mineBlock([
           
           Tx.contractCall("nft", "mint!", [types.uint(200), types.some(types.ascii("ummar.jpeg"))], deployer.address),
           Tx.contractCall("nft", "get-owner", [types.uint(1)], deployer.address)
          
        ]);

        assertEquals(block.receipts.length, 2);
        assertEquals(block.height, 2);
        
        block.receipts[0].result.expectOk()
        .expectAscii("Success")

        const owner = block.receipts[1].result.expectOk().expectSome()

        assertEquals(owner, deployer.address)
        
    },
});

Clarinet.test({
    name: "Ensure that transfer is working properly!",
    async fn(chain: Chain, accounts: Map<string, Account>) {

        const deployer = accounts.get("deployer")!;
        const wallet2 = accounts.get("wallet_1")!;

        let block = chain.mineBlock([
           
           Tx.contractCall("nft", "mint!", [types.uint(200), types.some(types.ascii("ummar.jpeg"))], deployer.address),
           Tx.contractCall("nft", "transfer", [types.uint(1), types.principal(deployer.address), types.principal(wallet2.address)], deployer.address),
           Tx.contractCall("nft", "get-owner", [types.uint(1)], deployer.address)
          
        ]);

        assertEquals(block.receipts.length, 3);
        assertEquals(block.height, 2);
        
        block.receipts[0].result.expectOk()
        .expectAscii("Success")

        block.receipts[1].events.expectNonFungibleTokenTransferEvent(
            types.uint(1),
            deployer.address, 
            wallet2.address, 
            `${deployer.address}.nft`,
            "cohort-art"
        )

        const owner = block.receipts[2].result.expectOk().expectSome()

        assertEquals(owner, wallet2.address)
        
    },
});

Clarinet.test({
    name: "Ensure that burn is working properly!",
    async fn(chain: Chain, accounts: Map<string, Account>) {

        const deployer = accounts.get("deployer")!;
        const wallet2 = accounts.get("wallet_1")!;

        let block = chain.mineBlock([
           
           Tx.contractCall("nft", "mint!", [types.uint(200), types.some(types.ascii("ummar.jpeg"))], deployer.address),
           Tx.contractCall("nft", "burn!", [types.uint(1)], deployer.address),
           Tx.contractCall("nft", "get-owner", [types.uint(1)], deployer.address)
          
        ]);

        assertEquals(block.receipts.length, 3);
        assertEquals(block.height, 2);
        
        block.receipts[0].result.expectOk()
        .expectAscii("Success")

        block.receipts[1].events.expectNonFungibleTokenBurnEvent(
            types.uint(1),
            deployer.address, 
            `${deployer.address}.nft`,
            "cohort-art"
        )

        block.receipts[2].result.expectOk().expectNone()
        
    },
});