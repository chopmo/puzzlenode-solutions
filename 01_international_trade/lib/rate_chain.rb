
class RateChain
  def initialize(rates)
    @rates = rates
  end

  def self.from_rates(rates, target_currency)
    # We're going to cheat and assume that there is only one rate with
    # the target "to" currency.
    seen_currencies = []

    chain = []
    last_rate = rates.find { |r| r.to == target_currency }
    seen_currencies << last_rate.from
    seen_currencies << last_rate.to
    chain << last_rate

    loop do
      initial_chain_size = chain.size

      rates.each do |r|
        if r.to == chain.first.from && !seen_currencies.include?(r.from)
          chain.unshift(r)
          seen_currencies << r.from
        end
      end
      
      return RateChain.new(chain) unless chain.size > initial_chain_size
    end
  end

  def supports?(from, to)
    !!get_subchain(from, to)
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
