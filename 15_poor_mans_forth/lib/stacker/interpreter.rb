require 'stacker/root_interpreter'

module Stacker
  class Interpreter
    include StackOperations

    attr_reader :stack

    def initialize
      @stack = []
      @interpreters = [RootInterpreter.new(@stack)]
    end

    def execute(cmd)
      @interpreters.last.execute(cmd)
    end

    def push_processor(p)
      @processors.push(p)
    end

    def pop_processor
      @processors.pop
    end
  end
end
