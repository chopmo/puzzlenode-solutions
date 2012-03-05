module Secrets
  module Ciphers
    class Vigenere < Cipher
      def initialize(key)
        @key = key.strip
        @key_index = 0
      end

      def decrypt(enc)
        enc.chars.map { |c| decrypt_char(c) }.join
      end
      
      def decrypt_char(c)
        return c unless letters.include?(c)
        decrypted = shift_char(c, -current_shift)
        inc_key_index
        decrypted
      end

      def inc_key_index
        @key_index = (@key_index + 1) % @key.size
      end

      def current_shift
        @key[@key_index].ord - letters.first.ord
      end

      private
      def shift_char(c, amount)
        char_idx = letters.index(c)
        return c unless char_idx
        shifted_idx = (char_idx + amount + letters.size) % letters.size
        letters[shifted_idx]
      end
    end
  end
end
