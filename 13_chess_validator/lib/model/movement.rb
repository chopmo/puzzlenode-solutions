# Design notes:
# =============
#
# Originally I wanted to name this class Move, but then it occurred to
# me that the term Move in this project would automatically be
# percieved as "chess move". That is, something involving source and
# destination positions, but also a piece on a board, subject to a set
# of rules.
#
# What I want to express here is simply the movement part of the chess
# move.

class Movement
  attr_reader :from
  attr_reader :to
  
  def initialize(from, to)
    @from = from
    @to = to
  end

  def vertical?
    col_delta.zero?
  end

  def horizontal?
    row_delta.zero?
  end

  def diagonal?
    col_delta.abs == row_delta.abs
  end

  def col_delta
    @to[0].ord - @from[0].ord
  end
  
  def row_delta
    @to[1].ord - @from[1].ord
  end

  def from_row
    @from[1].to_i
  end
end


