require 'user_repository'
require 'input_parser'
require 'connections'

class Puzzle
  def initialize(text)
    @repo = InputParser.new(text).parse
  end

  def solve
    out = ""
    @repo.users.each do |user|
      out += user.name + "\n"
      level = 1
      while true
        conns = Connections.new(@repo, user.name).on_level(level)
        break if conns.empty?
        out += conns.sort.join(", ") + "\n"
        level += 1
      end
      out += "\n" # Note: Trailing newline had to be removed before submitting
    end
    out
  end
end


