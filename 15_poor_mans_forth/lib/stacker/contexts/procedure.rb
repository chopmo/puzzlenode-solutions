require 'stacker/contexts/context'

module Stacker
  module Contexts
    class Procedure < Context
      def self.create(interpreter)
        p = new(interpreter)
        interpreter.push_context(p)
        p
      end

      def initialize(interpreter)
        super(interpreter)
        @commands = []
      end

      def execute(cmd)
        if cmd == "/PROCEDURE"
          end_definition
        else
          @commands << cmd
        end
      end

      def run
        @commands.each do |cmd|
          @interpreter.execute(cmd)
        end
      end

      def end_definition
        @interpreter.pop_context
      end
    end
  end
end
