from pymerkle import MerkleTree, MerkleVerifier


tree = MerkleTree()
v = MerkleVerifier()


# Populate tree with some records

for i in range(7):
    tree.encrypt('%d-th record' % i)


# Prove and verify encryption of 2nd record

challenge = b'45c44059cf0f5a447933f57d851a6024ac78b44a41603738f563bcbf83f35d20'
proof = tree.generate_audit_proof(challenge, commit=True)
assert v.verify_proof(proof)


# Save current tree state

subhash = tree.root_hash


# Append further leaves

for i in range(7, 10):
    tree.encrypt('%d-th record' % i)


# Prove and verify saved previous state

proof = tree.generate_consistency_proof(subhash, commit=True)
assert v.verify_proof(proof)