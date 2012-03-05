require 'stacker/contexts/context'

module Stacker
  module Contexts
    class TimesStatement < Context
      def self.create(interpreter)
        stmt = new(interpreter)
        interpreter.push_context(stmt)
      end

      def initialize(interpreter)
        super
        @counter = pop
        @commands = []
      end

      def execute(cmd)
        if (cmd == "/TIMES")
          run
        else
          @commands.push(cmd)
        end
      end

      def run
        @counter.times do 
          @commands.each do |cmd|
            root_context.execute(cmd)
          end
        end
        @interpreter.pop_context
      end
    end
  end
end
