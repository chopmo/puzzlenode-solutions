$:.unshift("lib")

require 'input_parser'
require 'cave'

parser = InputParser.new(open("data/complex_cave.txt"))
cave = Cave.new(parser.tiles)
parser.num_units.times { cave.add_water }
open("results.txt", "w") do |f|
  f.write(cave.result_string)
end
