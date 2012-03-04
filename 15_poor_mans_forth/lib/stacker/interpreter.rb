require 'stacker/contexts'

module Stacker
  class Interpreter
    attr_reader :stack

    def initialize
      @stack = []
      @interpreters = [Contexts::Root.new(self)]
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
