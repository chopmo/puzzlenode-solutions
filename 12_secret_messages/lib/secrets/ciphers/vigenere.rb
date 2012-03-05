module Secrets
  module Ciphers
    class Vigenere < Cipher
      def initialize(key)
        @key = key
      end

      def decrypt(enc)
        enc.chars.map { |c| decrypt_char(c) }.join
      end
      
      def decrypt_char(c)
        c
      end

    end
  end
end
