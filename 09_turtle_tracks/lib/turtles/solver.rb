require 'turtles/canvas'
require 'turtles/interpreter'
require 'turtles/turtle'

module Turtles
  class Solver
    def initialize(filename)
      @input_lines = File.readlines(filename)
      @interpreter = Interpreter.new(command_lines)
      @turtle = Turtle.new(initial_position, 0)
    end

    def canvas_size
      @input_lines.first.to_i
    end

    def command_lines
      @input_lines.drop(2)
    end

    def initial_position
      [(canvas_size/2).floor, (canvas_size/2).floor]
    end

    def run
      @canvas = Canvas.new(canvas_size)

      puts @turtle

      @canvas.mark(@turtle.position)
      while cmd = @interpreter.read_command
        @turtle.execute(cmd)
        puts "Executing #{cmd}: #{@turtle}"

        while @turtle.move
          puts "Moving: #{@turtle}"
          @canvas.mark(@turtle.position)
        end
      end

      puts "Resulting canvas:"
      puts @canvas.to_s

      puts "Also writing canvas to solution.txt"
      File.open("solution.txt", "w") do |f|
        f.write(@canvas.to_s)
      end
    end
  end
end
