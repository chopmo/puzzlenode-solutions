module Secrets
  module Ciphers
    class Caesar
      attr_accessor :shift

      def initialize(shift = 0)
        @shift = shift
      end

      def encrypt(text)
        text.chars.map { |c| shift_char(c, +1) }.join
      end

      def decrypt(text)
        text.chars.map { |c| shift_char(c, -1) }.join
      end

      def letters
        ('A'..'Z').to_a
      end

      def valid_shifts
        (0...letters.length)
      end

      
      private
      def shift_char(c, direction)
        char_idx = letters.index(c)
        return c unless char_idx
        shifted_idx = (char_idx + (@shift * direction) + letters.size) % letters.size
        letters[shifted_idx]
      end
    end
  end
end
