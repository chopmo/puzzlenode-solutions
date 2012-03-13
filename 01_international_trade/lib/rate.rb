require 'bigdecimal'

class Rate < Struct.new(:from, :to, :conversion)
  def convert(amount)
    amount = BigDecimal.new(amount)
    bankers_round(amount * BigDecimal.new(conversion.to_s)) # This is pretty awful :-/
  end

  private
  def bankers_round(amount)
    if(amount.frac == BigDecimal.new("0.5"))
      amount.ceil.even? ? amount.ceil : amount.floor
    else
      amount.round
    end
  end

end
