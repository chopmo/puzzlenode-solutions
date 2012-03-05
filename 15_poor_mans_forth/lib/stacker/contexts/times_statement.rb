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
        @running = false
      end

      def execute(cmd)
        if @running
          # puts "RUNNING, executing #{cmd} on parent #{parent_context}"
          parent_context.execute(cmd)
        elsif (cmd == "/TIMES")
          @running = true
          run
          @interpreter.pop_context
        else
          @commands.push(cmd)
        end
      end

      def run
        # puts "Parent context is #{parent_context}"
        @counter.times do 
          @commands.each do |cmd|
            @interpreter.execute(cmd)
          end
        end
      end
    end
  end
end
