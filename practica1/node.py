import sys
import inspect
import heapq, random

class Node:
    """
    This class is useful for defining each state in the graph as a node, storing all the 
    useful information.
    """

    def __init__(self, state, parent, operator, cost):
        """
        A node object will store: the current game state, the list of operators from root to the node, and
        the total cumulative cost
        """
        self.state = state
        if(parent is None): 
            # filling in the root node
            self.operations = []
            self.cumulative = cost
        else: 
            # we add the operator to the list of operators of the parent
            self.operations = Node.getOperations(parent) + [operator] 
            # we add the cost to the cumulative cost of the parent
            self.cumulative = Node.getCumulative(parent) + cost

    def getState(self):
        return self.state

    def getCumulative(self):
        return self.cumulative

    def getOperations(self):
        return self.operations
        
    
            


