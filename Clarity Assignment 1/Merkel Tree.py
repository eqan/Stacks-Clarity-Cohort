from typing import List
import typing
import random
from copy import deepcopy
import base64

def generateRandomBinaryString(p):
    key1 = ""
    for i in range(p):
        temp = str(random.randint(0, 1))
        key1 += temp
    return(key1)


class Node:
    def __init__(self, left, right, value: str)-> None:
        self.left: Node = left
        self.right: Node = right
        self.value = value

    def calculateHash(s):
        s = str(s)
        s = s.encode("utf-8")
        s = base64.b64encode(s)
        return s

    def decodeHash(s):
        s = base64.b64decode(s)
        s = s.decode("utf-8")
        return s

class MerkleTree:
    def __init__(self, values: List[str])-> None:
        self.__buildTree(values)

    def __buildTree(self, values: List[str])-> None:
        leaves: List[Node] = [Node(None, None, Node.calculateHash(e)) for e in values]
        if len(leaves) % 2 == 1:
            leaves.append(leaves[-1:][0])
        self.root: Node = self.__buildTreeRec(leaves)

    def __buildTreeRec(self, nodes: List[Node])-> Node:
        half: int = len(nodes) // 2

        if len(nodes) == 2:
            return Node(nodes[0], nodes[1], Node.calculateHash(nodes[0].value + nodes[1].value))

        left: Node = self.__buildTreeRec(nodes[:half])
        right: Node = self.__buildTreeRec(nodes[half:])
        value: str = Node.calculateHash(left.value + right.value)
        return Node(left, right, value)

    def printTree(self)-> None:
        self.__printTreeRec(self.root)

    def findDirtChunk(self, merkelNode, merkel2Node)-> None:
        if merkelNode != None:
            if(merkelNode.value != merkel2Node.value):
                print("Original Chunk: " + str(Node.decodeHash(merkelNode.value)))
                print("Modified Chunk: " + str(Node.decodeHash(merkel2Node.value)))
            self.findDirtChunk(merkelNode.left, merkel2Node.left)
            self.findDirtChunk(merkelNode.right, merkel2Node.right)
    

    def __printTreeRec(self, node)-> None:
        if node != None:
            print(node.value)
            self.__printTreeRec(node.left)
            self.__printTreeRec(node.right)

    def getRootHash(self)-> str:
        return Node.decodeHash(self.root.value)
    
elems = generateRandomBinaryString(8)
elems_list = list(elems)
mtree = MerkleTree(elems_list)

modified_elems = deepcopy(elems)
modifiedElems_list = list(modified_elems)
if(modified_elems[len(elems)//2] == 1):
    modifiedElems_list[len(elems)//2] = '0'
else:
    modifiedElems_list[len(elems)//2] = '1'
modified_elems = "".join(modifiedElems_list)
mtree_2 = MerkleTree(modifiedElems_list)

hash1 = str(mtree.getRootHash())
hash2 = str(mtree_2.getRootHash())

hash1_list = set(hash1)
hash2_list = set(hash2)

print(f"Original String: {str(elems_list)}")
print(f"Modified String: {str(modifiedElems_list)}")

print(f"Hash for original string: {hash1}\n")
print(f"Hash for modified string: {hash2}\n")
if(hash1 == hash2):
    print("Yes the hashes match!")
else:
    print("No the hashes don't match!\n")
    print("Now discovering the faulted chunk in the modified merkel tree....\n")
    mtree_2.findDirtChunk(mtree.root, mtree_2.root)