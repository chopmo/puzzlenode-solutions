require 'chain_builder'

class RateChain
  def initialize(rates)
    @rates = rates
  end

  def supports?(from, to)
    !!subchain(from, to)
  end

  def convert(amount, from, to)
    return amount if from == to
    subchain(from, to).each do |rate|
      amount = rate.convert(amount)
    end
    amount
  end


  def self.from_rates(rates, target_currency)
    new(ChainBuilder.new(rates, target_currency).rate_chain)
  end

  private
  def subchain(from, to)
    subchain = @rates.drop_while { |r| r.from != from }
    subchain = subchain.reverse.drop_while { |r| r.to != to }
    return nil if subchain.empty? || subchain.first.to != to

    subchain.reverse
  end
end
