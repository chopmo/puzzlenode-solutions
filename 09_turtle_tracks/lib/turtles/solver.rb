require 'turtles/canvas'
module Turtles
  class Solver
    def initialize(filename)
      @input_lines = File.readlines(filename)
    end

    def canvas_size
      @input_lines.first.to_i
    end


    def run
      @canvas = Canvas.new(canvas_size)
      puts "Resulting canvas:"
      puts @canvas.to_s
    end
  end
end
