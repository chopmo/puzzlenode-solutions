require 'bigdecimal'
require 'rounding'

class Rate < Struct.new(:from, :to, :conversion)
  include Rounding

  def convert(amount)
    BigDecimal.new(amount) * BigDecimal.new(conversion.to_s)
  end
end
