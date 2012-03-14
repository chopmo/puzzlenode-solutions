require 'rate_chain'

class ChainBuilder
  def initialize(rates, target_currency)
    @all_rates = rates
    @target = target_currency
    build_rate_chain
  end

  def self.build(rates, target_currency)
    new(rates, target_currency).chain
  end

  def chain
    RateChain.new(@rates)
  end


  private
  def build_rate_chain
    # We're going to cheat and assume that there is only one rate with
    # the target "to" currency.
    @rates = [find_last_rate]

    loop do
      next_link = @all_rates.find { |r|
        r.to == @rates.first.from && !seen_currency?(r.from)
      }
      break unless next_link
      @rates.unshift(next_link)
    end
  end

  def seen_currency?(c)
    seen_currencies.include?(c)
  end

  def seen_currencies
    @rates.map { |r| [r.from, r.to] }.flatten.uniq
  end

  def find_last_rate
    @all_rates.find { |r| r.to == @target }    
  end
end
