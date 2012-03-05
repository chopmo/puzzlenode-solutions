require 'secrets/ciphers/caesar'

# XXX: Use something like Ruby-Wordnet to look for an English word
module Secrets
  class CaesarCracker
    def initialize(enc)
      @enc = enc
    end

    def crack
      puts "Which of these look right?"
      cipher = Ciphers::Caesar.new
      cipher.valid_shifts.each do |shift|
        cipher.shift = shift
        puts "%3s: #{cipher.decrypt(@enc)}" % shift
      end
      print "> "
      cipher.shift = $stdin.gets.to_i
      cipher.decrypt(@enc)
    end
  end
end
