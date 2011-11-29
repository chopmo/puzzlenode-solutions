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
    catch (:invalid_action) do
      out = self.clone
      turn.actions.each do |action|
        next if action.unresolved?
        if action.action_type == "+"
          if action.player
            out.remove_from_transit(action.card)
          end

          out.check_not_on_table(action.card)
          out.hands[turn.player] << action.card
        else
          out.hands[turn.player].delete(action.card)
          target = (action.player == "discard") ? out.discards : out.transit
          target << action.card
        end
      end
      return out
    end
    nil
  end

  def card_exists?(card)
    (@hands.values + @discards + @transit).flatten.include?(card)
  end

  def remove_from_transit(card)
    @transit -= [card]
  end

  def check_not_on_table(card)
    if card_exists?(card)
      # puts "ERROR: Card #{card} already exists"
      throw :invalid_action
    end
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
