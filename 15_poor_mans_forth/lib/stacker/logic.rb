require 'stacker/stack_operations'

module Stacker
  class Logic
    include StackOperations

    def initialize(data, interpreter)
      @data = data
      @interpreter = interpreter
    end
    
    def execute(cmd)
      method_name = cmd.downcase.gsub(/=/, 'equals')
      send(method_name)
    end

    def <
      b, a = pop, pop
      push a < b ? :true : :false
    end

    def >
      b, a = pop, pop
      push a > b ? :true : :false
    end

    def equals
      push pop == pop ? :true : :false
    end

    def if
      test = pop
      puts "Test is #{test}"
      if test == :true
      end
    end
  end
end
