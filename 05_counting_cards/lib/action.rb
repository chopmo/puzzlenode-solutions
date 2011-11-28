class Action
  attr_reader :player
  attr_reader :action_type
  attr_reader :card

  def initialize(options = {})
    @player = options[:player]
    @action_type = options[:action_type]
    @card = options.fetch(:card, unknown_card)
  end

  def unresolved?
    card == unknown_card
  end

  def resolve_with(action)
    Action.new(player: player,
               action_type: action_type,
               card: action.card)
  end

  def ==(other)
    %w{ player action_type card }.all? { |attr| self.send(attr) == other.send(attr) }
  end

  def to_s
    "#{action_type}#{card}" + (player.nil? ? "" : ":#{player}")
  end
  
  private
  def unknown_card
    "??"
  end
end
