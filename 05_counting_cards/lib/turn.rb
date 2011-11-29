# A turn consists of a number of actions, for example "+5C or
# -10H:Shady". A turn may have 0 or more signals associated with it.
class Turn
  attr_reader :actions
  attr_reader :signals
  attr_reader :player
  
  def initialize(options = {})
    @actions = options.fetch(:actions, [])
    @signals = options.fetch(:signals, [])
    @player = options.fetch(:player, "discard")
  end

  def apply_to(cards)
    resolutions.any? { |resolution| cards.apply(resolution) }
  end

  def resolved?
    @signals.empty?
  end

  def resolve_with(signalled_actions)
    resolution = Turn.new(player: player)
    signal_idx = 0
    actions.each do |action|
      if action.unresolved?
        resolution.actions << action.resolve_with(signalled_actions[signal_idx])
        signal_idx += 1
      else
        resolution.actions << action
      end
    end
    resolution
  end

  def resolutions
    return [self] if resolved?
    @signals.map { |signaled_actions| self.resolve_with(signaled_actions) }
  end

  def ==(other)
    %w{ actions signals player }.all? { |attr| self.send(attr) == other.send(attr) }
  end

  def to_s
    "#{player}: #{actions.join(' ')}"
  end

end
