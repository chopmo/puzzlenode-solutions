require 'secrets/ciphers'
require 'secrets/caesar_cracker'

module Secrets
  class Solver
    def initialize(filename)
      @input_lines = File.readlines(ARGV[0])
      @solution_filename = "solution.txt"
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
      msg = vigenere_decrypt(enc_message, keyword)
      puts "Message is: \n#{msg}"
      write_solution(msg)
      puts "This message was also written to #{@solution_filename}"
    end

    def crack_caesar(enc)
      CaesarCracker.new(enc).crack
    end

    def vigenere_decrypt(enc, key)
      Ciphers::Vigenere.new(key).decrypt(enc)
    end

    def write_solution(msg)
      File.open(@solution_filename, "w") do |f|
        f.write(msg)
      end
    end

  end
end
