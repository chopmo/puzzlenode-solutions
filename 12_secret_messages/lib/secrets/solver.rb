require 'secrets/ciphers'
require 'secrets/caesar_cracker'

module Secrets
  class Solver
    def initialize(filename)
      @input_lines = File.readlines(ARGV[0])
    end

    def enc_keyword
      @input_lines.first
    end

    def enc_message
      @input_lines.drop(2).join
    end

    def run
      keyword = crack_caesar(enc_keyword)
      puts "Cracked keyword is: #{keyword}"
    end

    def crack_caesar(enc)
      CaesarCracker.new(enc).crack
    end
  end
end
