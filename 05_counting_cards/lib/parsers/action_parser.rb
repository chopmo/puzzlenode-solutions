require 'action'

class ActionParser
  def initialize(text)
    @text = text
  end

  def parse
    md = /([+-])([^:]+):?(.*)/.match(@text)
    player = md[3].empty? ? nil : md[3]
    Action.new(action_type: md[1], card: md[2], player: player)
  end

end
