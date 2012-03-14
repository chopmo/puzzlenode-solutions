class Solver < Struct.new(:transactions, :sku, :rate_chain, :target_currency)
  def solution
    transactions
      .select { |t| t.sku == sku }
      .map { |t| rate_chain.convert(t.amount, t.currency, target_currency) }
      .map { |a| BigDecimal.new(a) }
      .inject(:+)
  end
end
