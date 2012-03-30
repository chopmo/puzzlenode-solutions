require 'json'

class Board
  def self.from_json(json)
    Board.new(json)
  end


  def initialize(json)
    @cells = JSON.parse(json).map { |row| row.split(" ").map(&:to_i) }
  end

  def cell(r, c)
    @cells[r][c]
  end


end
