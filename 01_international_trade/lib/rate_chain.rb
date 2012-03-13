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
    subchain = []
    @rates.each do |rate|
      if subchain.empty?
        if rate.from == from
          subchain << rate
          return subchain if rate.to == to
        end
      else
        subchain << rate
        return subchain if rate.to == to
      end
    end
    nil
  end
end
