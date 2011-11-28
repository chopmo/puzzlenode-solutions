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
