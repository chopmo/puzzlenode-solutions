class Solver < Struct.new(:transactions, :sku, :rate_chain, :target_currency)

  def solution
    sum = BigDecimal.new("0.0")
    # transactions.select { |t| t.sku == sku }.map { |t| rate_chain
  end


end
