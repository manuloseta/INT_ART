import sys
import inspect
import heapq, random

class Node:

    

    def __init__(self, state, parent, operator, cost):
        self.state = state
        self.parent = parent
        self.operator = operator
        self.cost = cost

    def getState(self):
        return self.state

    def getParent(self):
        return self.parent

    def getOperator(self):
        return self.operator

    def getCost(self):
        return self.cost
        
    def calcCumulative(self):
        node = self
        cost = 0
        while node.parent is not None:
            cost += node.cost
            node = node.parent
        return cost
        
    
            


