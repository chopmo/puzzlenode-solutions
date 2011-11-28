$:.unshift('lib')

require 'parsers/turn_parser'
require 'puzzle'

turns = TurnParser.new(open("data/input.txt").read).parse
result = Puzzle.new(turns).solve_for("Lil")

puts result
open("results.txt", "w") do |f|
  f.write(result)
end

