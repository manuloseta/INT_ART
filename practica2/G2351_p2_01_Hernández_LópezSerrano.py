import time
import numpy as np
from game import (
    TwoPlayerGameState,
)
from reversi import from_dictionary_to_array_board
from tournament import (
    StudentHeuristic,
    Tournament
)

class Solution1(StudentHeuristic):
  def get_name(self) -> str:
    return "dummy_2351_01"
  def evaluation_function(self, state: TwoPlayerGameState) -> float:
    # let's use an auxiliary function
    aux = self.dummy(123)
    return aux

  def dummy(self, n: int) -> int:
    return n + 1

class Solution2(StudentHeuristic):
  def get_name(self) -> str:
    return "random_2351_01"

  def evaluation_function(self, state: TwoPlayerGameState) -> float:
    return float(np.random.rand())

class Solution3(StudentHeuristic):
  #! Next: compute possible next moves as well, add multiplier??
  def get_name(self) -> str:
    return "four_sectors_2351_01"
  def evaluation_function(self, state: TwoPlayerGameState) -> float:
    board_array = state.board
    sector_values={1: 0.4, 2: 0.2, 3: 0.1, 4: 0.8}
    score=0
    label=state.player_max.label
    for key in board_array.keys():
      if board_array.get(key) == label:
        score += sector_values.get(Solution3.sector(Solution3, key))
      else:
        score -= sector_values.get(Solution3.sector(Solution3, key))

    return score

  def is_corner(self, position: tuple, height=8, width=8) -> bool:
    corners = [(1,1),(1,height),(width,1),(width,height)]
    return (position in corners)

  def is_in_sector(self, position: tuple, sector=1, height=8, width=8) -> bool:
    # sector 1 is the border, all the way to 4, the center
    x,y=position[0],position[1]
    first_bool = (x==sector or x==width-(sector-1)) and (y>=sector and y<=height-(sector-1))
    second_bool = (y==sector or y==height-(sector-1)) and (x>=sector and x<=width-(sector-1))
    if Solution3.is_corner(Solution3, position):
      if sector==4: 
        return True
      else: 
        return False
    return (first_bool or second_bool)

  def sector(self, position: tuple, height=8, width=8) -> int:
    # sector 1 is the border, all the way to 4, the center
    for sector in [1,2,3,4]:
      if(Solution3.is_in_sector(Solution3, position, sector)):
        return sector