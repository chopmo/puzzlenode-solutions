$:.unshift("lib")

require 'input_parser'
require 'cave'

class CaveSimulation
  def initialize
    parser = InputParser.new(open("data/simple_cave.txt"))
    @cave = Cave.new(parser.tiles)
  end

  def run
    print_cave
    print_prompt
    while wait_for_keyboard
      add_water
      print_cave
      print_prompt
    end
  end

  def add_water
    @cave.add_water
  end
  
  def print_cave
    print "\e[2J\e[f" + @cave.to_s
  end

  def print_prompt
    puts "\nPress <enter> to add water, q<enter> to quit"
  end

  def wait_for_keyboard
    gets !~ /q/
  end
end

CaveSimulation.new.run
