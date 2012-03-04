require 'stacker/contexts/context'
require 'stacker/contexts/if_statement'

module Stacker
  module Contexts
    class Root < Context
      def execute(cmd)
        if %(< > = IF ADD SUBTRACT MULTIPLY DIVIDE MOD).include?(cmd)
          method_name = cmd.downcase.gsub(/=/, 'equals')
          send(method_name)
        else
          push_literal(cmd)
        end
      end

      def push_literal(cmd)
        push(cmd)
      end

      def add
        push(pop_int + pop_int)
      end

      def subtract
        b, a = pop_int, pop_int
        push(a - b)
      end

      def multiply
        push(pop_int * pop_int)
      end

      def divide
        b, a = pop_int, pop_int
        push(a / b)
      end

      def mod
        b, a = pop_int, pop_int
        push a % b
      end
      def <
        b, a = pop_int, pop_int
        push a < b ? :true : :false
      end

      def >
        b, a = pop_int, pop_int
        push a > b ? :true : :false
      end

      def equals
        push pop == pop ? :true : :false
      end

      def if
        IfStatement.create(@interpreter)
      end
    end
  end
end
