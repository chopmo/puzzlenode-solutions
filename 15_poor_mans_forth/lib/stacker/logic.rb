require 'stacker/stack_operations'

module Stacker
  class Logic
    include StackOperations

    def initialize(stack)
      @stack = stack
    end
    
    def execute(cmd)
      method_name = cmd.gsub(/=/, 'equals')
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
  end
end
