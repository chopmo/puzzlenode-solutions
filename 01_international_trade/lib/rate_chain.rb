require 'chain_builder'

class RateChain
  def initialize(rates)
    @rates = rates
  end

  def supports?(from, to)
    !!get_subchain(from, to)
  end

  def self.from_rates(rates, target_currency)
    new(ChainBuilder.new(rates, target_currency).rate_chain)
  end

  private
  def get_subchain(from, to)
    subchain = @rates.drop_while { |r| r.from != from }
    subchain = subchain.reverse.drop_while { |r| r.to != to }
    return nil if subchain.empty? || subchain.first.to != to

    subchain.reverse
  end
end
