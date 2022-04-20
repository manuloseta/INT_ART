import time
import numpy as np
from game import (
    TwoPlayerGameState,
)
from reversi import Reversi
from tournament import (
    StudentHeuristic,
    Tournament
)

class Solution3(StudentHeuristic):
  def get_name(self) -> str:
    return "chica qué dices"
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
      return (sector==4)

    return (first_bool or second_bool)

  def sector(self, position: tuple, height=8, width=8) -> int:
    # sector 1 is the border, all the way to 4, the center
    for sector in [1,2,3,4]:
      if(Solution3.is_in_sector(Solution3, position, sector)):
        return sector

class Solution4(StudentHeuristic):
  def get_name(self) -> str:
    return "im about to crash"
  def evaluation_function(self, state: TwoPlayerGameState) -> float:
    board_array = state.board
    sector_values={1: 0.8, 2: 0.4, 3: 0.2, 4: 0.1, 5: 1.6}
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

  def sector(self, position: tuple, height=8, width=8) -> int:
    if Solution4.is_corner(Solution4, position): return 1
    if Solution4.is_around_corner(Solution4, position): return 2
    if Solution4.is_in_center(Solution4, position): return 5
    if Solution4.is_in_cross(Solution4, position): return 4
    return 3

  def is_around_corner(self, position: tuple, height=8, width=8) -> bool:
    around_corner = [(1,2),(2,1),(2,2),(7,1),(8,2),(7,2),(1,7),(2,8),(2,7),(7,8),(8,7),(7,7)]
    return (position in around_corner)

  def is_in_cross(self, position: tuple, height=8, width=8) -> bool:
    x,y=position[0],position[1]
    return ((x in [4,5]) or (y in [4,5]))

  def is_in_center(self, position: tuple, height=8, width=8) -> bool:
    x,y=position[0],position[1]
    return ((x in [4,5]) and (y in [4,5]))
    
class Solution5(StudentHeuristic):
  def get_name(self) -> str:
    return "saoko papi saoko"
  def evaluation_function(self, state: TwoPlayerGameState) -> float:
    board_array = state.board
    sector_values={1: 0.4, 2: 0.2, 3: 0.1, 4: 0.8}
    score=0
    label=state.player_max.label
    label2=state.next_player.label
    for key in board_array.keys():
      if board_array.get(key) == label:
        score += sector_values.get(Solution5.sector(Solution5, key))
      else:
        score -= sector_values.get(Solution5.sector(Solution5, key))

    valid_moves=Solution5.get_valid_moves(Solution5, state, label2)
    if label==label2:
      for move in valid_moves:
        score += 2*sector_values.get(Solution5.sector(Solution5, move))
    else:
      for move in valid_moves:
        score -= 10*sector_values.get(Solution5.sector(Solution5, move))


    return score

  def is_corner(self, position: tuple, height=8, width=8) -> bool:
    corners = [(1,1),(1,height),(width,1),(width,height)]
    return (position in corners)

  def is_in_sector(self, position: tuple, sector=1, height=8, width=8) -> bool:
    # sector 1 is the border, all the way to 4, the center
    x,y=position[0],position[1]
    first_bool = (x==sector or x==width-(sector-1)) and (y>=sector and y<=height-(sector-1))
    second_bool = (y==sector or y==height-(sector-1)) and (x>=sector and x<=width-(sector-1))
    if Solution5.is_corner(Solution5, position):
      return (sector==4)

    return (first_bool or second_bool)

  def sector(self, position: tuple, height=8, width=8) -> int:
    # sector 1 is the border, all the way to 4, the center
    for sector in [1,2,3,4]:
      if(Solution5.is_in_sector(Solution5, position, sector)):
        return sector

  def capture_enemy_in_dir(self, state: TwoPlayerGameState, move, player_label, delta_x_y) -> list:
        enemy = state.player2.label if player_label == state.player1.label else state.player1.label
        (delta_x, delta_y) = delta_x_y
        x, y = move
        x, y = x + delta_x, y + delta_y
        enemy_list_0 = []
        while state.board.get((x, y)) == enemy:
            enemy_list_0.append((x, y))
            x, y = x + delta_x, y + delta_y
        if state.board.get((x, y)) != player_label:
            del enemy_list_0[:]
        x, y = move
        x, y = x - delta_x, y - delta_y
        enemy_list_1 = []
        while state.board.get((x, y)) == enemy:
            enemy_list_1.append((x, y))
            x, y = x - delta_x, y - delta_y
        if state.board.get((x, y)) != player_label:
            del enemy_list_1[:]
        return enemy_list_0 + enemy_list_1

  def enemy_captured_by_move(self, state: TwoPlayerGameState, move, player_label) -> list:
      return Solution5.capture_enemy_in_dir(Solution5, state, move, player_label, (0, 1)) \
            + Solution5.capture_enemy_in_dir(Solution5, state, move, player_label, (1, 0)) \
            + Solution5.capture_enemy_in_dir(Solution5, state, move, player_label, (1, -1)) \
            + Solution5.capture_enemy_in_dir(Solution5, state, move, player_label, (1, 1))

  def get_valid_moves(self, state: TwoPlayerGameState, player_label, width=8, height=8) -> list:
        """Returns a list of valid moves for the player judging from the board."""
        return [(x, y) for x in range(1, width + 1)
                for y in range(1, height + 1)
                if (x, y) not in state.board.keys() and
                Solution5.enemy_captured_by_move(Solution5, state, (x, y), player_label)]



