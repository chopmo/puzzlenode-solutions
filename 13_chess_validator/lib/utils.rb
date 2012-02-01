require 'parsers/board_parser'
require 'parsers/movement_parser'
require 'parsers/results_parser'

class Utils
  def self.load_board(path)
    parse_file_with(path, BoardParser)
  end

  def self.load_movements(path)
    parse_file_with(path, MovementParser)
  end

  def self.load_results(path)
    parse_file_with(path, ResultsParser)
  end

  private
  def self.parse_file_with(path, klass)
    text = open(path).read
    klass.new(text).parse
  end
end
