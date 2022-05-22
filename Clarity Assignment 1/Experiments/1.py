import random
import base64

def calculateHash(s):
    s = s.encode("utf-8")
    s = base64.b64encode(s)
    return s

def decodeHash(s):
    s = base64.b64decode(s)
    s = s.decode("utf-8")
    return s

class Node:
   def __init__(self, data, index):
      self.left = None
      self.right = None
      self.index = index
      self.___data = data
      self.hash = calculateHash(data)

#    def insert(self, val):
#         if self.val:
#                     if self.left is None:
#                         self.left = Tree(val)
#                     else:
#                         self.left.insert(val)
#             elif val > self.val:
#                     if self.right is None:
#                         self.right = Tree(val)
#                     else:
#                         self.right.insert(val)
#         else:
#             self.val = val

   def insert(self, data, index):
       if self.___data:
            if index < self.index:
                if self.left is None:
                    self.left = Node(data, index)
                else:
                    self.left.insert(data, index)
            elif index > self.index:
                if self.right is None:
                    self.right = Node(data, index)
                else:
                    self.right.insert(data, index)
       else:
           self.___data = data
           self.hash = calculateHash(data)

def generateRandomBinaryString(p):
    key1 = ""
    for i in range(p):
        temp = str(random.randint(0, 1))
        key1 += temp
    return(key1)

def chunkify(s):
    if(len(s) <= 1):
        return False
    s1 = s[:len(s)//2]
    s2 = s[len(s)//2:]
    return [s1, s2]

def createMerkelTree(string, root):
    childs = chunkify(string) 
    if(childs == False):
        root.insert(string)
        print(root.left.right.hash)
        return root
    if(len(childs) > 1):
        for i in range(len(childs)):
            root.insert(childs[i], i)
        for child in childs:
            createMerkelTree(child, root)

def modifyChunk(string):
    return  True

def findDirtyChunk(string):
    return True

string = generateRandomBinaryString(8)
root = Node(string, 0)
root = createMerkelTree(string, root)
# left = root.left
# print(left.hash)
# print(decodeHash(left.hash))
