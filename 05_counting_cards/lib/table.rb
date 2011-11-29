# This class and Simulation is there the interesting (and messy) stuff happens.
# 
require 'delegate'

class Table
  attr_accessor :discards
  attr_accessor :transit

  def initialize
    @discards = []
    @transit = []
    @hands = {}
  end

  def apply(turn)
    self.clone.apply!(turn)
  end

  def apply!(turn)
    turn.actions.each do |action|
      next if action.unresolved?
      if action.action_type == "+"
        if action.player
          @transit -= [action.card]
        end

        return nil if card_exists?(action.card)
        hands[turn.player] << action.card
      else
        hands[turn.player].delete(action.card)
        target = (action.player == "discard") ? discards : transit
        target << action.card
      end
    end
    self
  end
  
  def card_exists?(card)
    (@hands.values + @discards + @transit).flatten.include?(card)
  end

  def to_s
    "Hands: \n" +
      @hands.map { |player, hand| "  #{player}: #{hand.to_s}" }.join("\n") + "\n" + 
      "Discards: #{@discards.to_s}\n" +
      "Transit: #{@transit.to_s}"
  end

  def clone
    Marshal.load(Marshal.dump(self))
  end

  class Hands < SimpleDelegator
    def [](name)
      # This is needed (I think) because using a default proc on the
      # @hands Hash is not supported when it needs to be marshalled.
      self[name] = [] unless has_key?(name)
      super
    end
  end

  def hands
    Hands.new(@hands)
  end
end
