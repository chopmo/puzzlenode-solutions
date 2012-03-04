require 'stacker/stack_operations'
require 'stacker/if_statement'

module Stacker
  class Logic
    include StackOperations

    def initialize(stack, interpreter)
      @stack = stack
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
      puts "creating if statement"
      IfStatement.create(pop, @interpreter)
      # test = pop
      # puts "Test is #{test}"
      # @interpreter.push_processor(IfStatement.new(test))
    end
  end
end
