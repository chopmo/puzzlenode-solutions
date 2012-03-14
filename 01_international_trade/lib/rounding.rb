module Rounding
  def bankers_round(amount)
    amount *= 100
    amount = if(amount.frac == BigDecimal.new("0.5"))
               amount.ceil.even? ? amount.ceil : amount.floor
             else
               amount.round
             end
    amount / BigDecimal.new("100.0")
  end
end
