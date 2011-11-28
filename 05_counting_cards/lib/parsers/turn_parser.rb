# This is a convenience class to parse the text format specified in
# the puzzle description. It emits an array of Turn instances.
require 'parsers/action_parser'
require 'turn'

class TurnParser
  def initialize(text)
    @text = text
  end

  def parse
    turns = []
    turn = nil
    @text.lines.each do |line|
      line = line.sub(/\#.*/, "").strip
      next if line.empty?
      case line
      when /\*/
        turn.signals << parse_signal(line)
      else
        turn = parse_turn(line)
        turns << turn
      end
    end
    turns
  end

  private

  def parse_turn(line)
    md = /(\w+)\s(.+)/.match(line)
    player = md[1]
    actions = parse_actions(md[2])
    Turn.new(player: player, actions: actions)
  end

  def parse_signal(line)
    md = /\*\s*(.+)/.match(line)
    actions = parse_actions(md[1])
  end

  def parse_actions(s)
    s.split(/\s/).map { |action_text| ActionParser.new(action_text).parse }
  end
end
