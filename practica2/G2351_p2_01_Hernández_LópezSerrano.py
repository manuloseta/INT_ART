import time
import numpy as np
from game import (
    TwoPlayerGameState,
)
from reversi import from_dictionary_to_array_board
from tournament import (
    StudentHeuristic,
)

class Solution1(StudentHeuristic):
  def get_name(self) -> str:
    return "solution1"
  def evaluation_function(self, state: TwoPlayerGameState) -> float:
    # let's use an auxiliary function
    aux = self.dummy(123)
    return aux

  def dummy(self, n: int) -> int:
    return n + 1

class Solution2(StudentHeuristic):
  def get_name(self) -> str:
    return "solution2"

  def evaluation_function(self, state: TwoPlayerGameState) -> float:
    return float(np.random.rand())

class Solution3(StudentHeuristic):
  def get_name(self) -> str:
    return "solution3"
  def evaluation_function(self, state: TwoPlayerGameState) -> float:
    board_array = from_dictionary_to_array_board(state.board, 8 ,8)
    print(board_array)
    print(state.board)

    return 1

def is_border(position=(1,1), height=8, width=8) -> bool:
  x,y=position[0],position[1]
  return (x==1 or y==1 or x==width or y==height)

def is_corner(position=(1,1), height=8, width=8) -> bool:
  x,y=position[0],position[1]
  corners = [(1,1),(1,8),(8,1),(8,8)]
  return (position in corners)
