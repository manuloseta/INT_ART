# search.py
# ---------
# Licensing Information:  You are free to use or extend these projects for
# educational purposes provided that (1) you do not distribute or publish
# solutions, (2) you retain this notice, and (3) you provide clear
# attribution to UC Berkeley, including a link to http://ai.berkeley.edu.
# 
# Attribution Information: The Pacman AI projects were developed at UC Berkeley.
# The core projects and autograders were primarily created by John DeNero
# (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# Student side autograding was added by Brad Miller, Nick Hay, and
# Pieter Abbeel (pabbeel@cs.berkeley.edu).


"""
In search.py, you will implement generic search algorithms which are called by
Pacman agents (in searchAgents.py).
"""

import util
from node import Node
from game import Directions

class SearchProblem:
    """
    This class outlines the structure of a search problem, but doesn't implement
    any of the methods (in object-oriented terminology: an abstract class).

    You do not need to change anything in this class, ever.
    """

    def getStartState(self):
        """
        Returns the start state for the search problem.
        """
        util.raiseNotDefined()

    def isGoalState(self, state):
        """
          state: Search state

        Returns True if and only if the state is a valid goal state.
        """
        util.raiseNotDefined()

    def getSuccessors(self, state):
        """
          state: Search state

        For a given state, this should return a list of triples, (successor,
        action, stepCost), where 'successor' is a successor to the current
        state, 'action' is the action required to get there, and 'stepCost' is
        the incremental cost of expanding to that successor.
        """
        util.raiseNotDefined()

    def getCostOfActions(self, actions):
        """
         actions: A list of actions to take

        This method returns the total cost of a particular sequence of actions.
        The sequence must be composed of legal moves.
        """
        util.raiseNotDefined()


def tinyMazeSearch(problem):
    """
    Returns a sequence of moves that solves tinyMaze.  For any other maze, the
    sequence of moves will be incorrect, so only use this for tinyMaze.
    """
    s = Directions.SOUTH
    w = Directions.WEST
    return  [s, s, w, s, w, w, s, w]

def GraphSearch(problem, open_list):
    """
    This method implements graph search given a problem, an open list structure,
    and a flag that accounts for the uniform cost search algorithm. The method uses 
    a closed list to insert already visited nodes so as to eliminate repeated states.

    Each of the following 4 search algorithms call this method with their respective open list
    structure.
    """

    node = Node(state=problem.getStartState(), parent=None, operator=None, cost=0) # We define the root node
    open_list.push(node)
    closed_list = []

    while open_list.isEmpty() is False: # Will only get out of the while loop if the algorithm fails to find a path
        node = open_list.pop()
        if problem.isGoalState(Node.getState(node)):
            return Node.getOperations(node) # In case of success, we return list of operators from initial state to goal state

        if Node.getState(node) not in closed_list: # We expand the current node if necessary
            closed_list.append(Node.getState(node))
            successors = problem.getSuccessors(Node.getState(node))
            for successor in successors: # We push in the open list a new node for every successor
                open_list.push(Node(state=successor[0], parent=node, operator=successor[1], cost=successor[2]))
                
    return [] # in case of failure, we return an empty list
    

def depthFirstSearch(problem):
    """
    Search the deepest nodes in the search tree first.
    The open list structure used is a stack
    """
    "*** YOUR CODE HERE ***"
    
    open_list = util.Stack()
    return GraphSearch(problem, open_list)
    

def breadthFirstSearch(problem):
    """
    Search the shallowest nodes in the search tree first.
    The open list structure used is a queue.
    """
    "*** YOUR CODE HERE ***"
    open_list = util.Queue()
    return GraphSearch(problem, open_list)

def uniformCostSearch(problem):
    """
    Search the node of least total cost first.
    The open list structure used is a priority queue.
    """
    "*** YOUR CODE HERE ***"

    def priorityFunction(node):
        """
        The priority function defined is the ucs function: it returns the cumulative cost
        from root to the current node
        """
        return Node.getCumulative(node)

    open_list = util.PriorityQueueWithFunction(priorityFunction)
    return GraphSearch(problem, open_list)

def nullHeuristic(state, problem=None):
    """
    A heuristic function estimates the cost from the current state to the nearest
    goal in the provided SearchProblem.  This heuristic is trivial.
    """
    return 0

def aStarSearch(problem, heuristic=nullHeuristic):
    """
    Search the node that has the lowest combined cost and heuristic first.
    The open list structure used is a priority queue with function. Said function
    will be defined by the heuristic.
    """
    "*** YOUR CODE HERE ***"

    def priorityFunction(node):
        """
        The priority function defined is the astar f function: it returns g+h 
        (the cumulative cost from the start state to the current state + the value of
        the heuristic)
        """
        return (heuristic(Node.getState(node), problem) + Node.getCumulative(node))

    open_list = util.PriorityQueueWithFunction(priorityFunction)
    return GraphSearch(problem, open_list)


# Abbreviations
bfs = breadthFirstSearch
dfs = depthFirstSearch
astar = aStarSearch
ucs = uniformCostSearch
