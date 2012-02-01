$:.unshift('lib')
require 'puzzle'
puts Puzzle.new(open(ARGV[0]).read).solve
