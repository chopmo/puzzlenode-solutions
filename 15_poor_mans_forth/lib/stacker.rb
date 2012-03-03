module Stacker
  class Interpreter
    attr_reader :stack

    def initialize
      @stack = []
    end

    def execute(cmd)
      stack << cmd 
    end
  end
end
