# This class is simply a driver to generate the required output format.
#
# It makes two passes:
#  1) Solve the puzzle, recording a list of applied turns (see Simulation)
#  2) Apply each of these turns, collecting the hands of a specific player

require 'simulation'
require 'table'

class Puzzle
  def initialize(turns)
    @turns = turns
  end

  def solve_for(player)
    applied_turns = []
    Simulation.apply_turn(Table.new, @turns, 0, applied_turns)

    table = Table.new
    out = ""
    applied_turns.each do |turn|
      table = table.apply(turn)
      if turn.player == player
        out += table.hands[player].join(" ") + "\n"
      end
    end
    out
  end
end
