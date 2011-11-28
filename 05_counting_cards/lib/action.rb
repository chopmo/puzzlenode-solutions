# An action is a single event in the game, eg. "Shady draws 5C", "Lil discards 10C" etc.
#
# Its components are
#  - peer player (ie. sender or receiver of card). May be "discard".
#  - action_type (+ or - depending on whether the player is receiving or sending the card)
#  - card (encoded as in the input, eg. 5C). May be unknown ("??")
#
# Instances of this class participate both as "actions" and as
# "signals" in a turn. During turn resolution, an unresolved action
# can #resolve_with a signalled action, returning the result of the
# merge (effectively the signal, but I wanted to keep this generic).
#
# An action is #unresolved? if we don't know the value of its card. In
# the simulation, this means that we'll apply signals to it if we have
# them.

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
