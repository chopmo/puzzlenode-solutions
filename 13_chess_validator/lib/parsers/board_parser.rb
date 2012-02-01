require 'model/board'

class BoardParser
  def initialize(text)
    @text = text
  end

  def parse
    board = Board.new
    row = 8
    @text.lines.each do |line|
      col = "a"
      line.strip.split(/ /).each do |s|
        if s != "--"
          board.add_piece(s.strip, "#{col}#{row}")
        end
        col.next!
      end
      row -= 1
    end

    board
  end
end
