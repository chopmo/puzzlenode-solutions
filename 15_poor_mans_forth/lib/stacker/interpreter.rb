require 'stacker/arithmetic'
require 'stacker/logic'
require 'stacker/stack_operations'

module Stacker
  class Interpreter
    include StackOperations

    attr_reader :stack

    def initialize
      @stack = []
      @arithmetic = Arithmetic.new(@stack)
      @logic = Logic.new(@stack)
    end

    def execute(cmd)
      if %(ADD SUBTRACT MULTIPLY DIVIDE MOD).include?(cmd)
        @arithmetic.execute(cmd)
      elsif %(< > =).include?(cmd)
        @logic.execute(cmd)
      else
        push_literal(cmd)
      end
      # puts "After #{cmd}, stack is #{stack}"
    end

    def push_literal(cmd)
      push(cmd.to_i)
    end
  end
end
