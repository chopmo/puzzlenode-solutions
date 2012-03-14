require 'rate_parser'
require 'rate_chain'
require 'transaction_parser'

require 'solver'


describe Solver do
  it "solves the sample case" do
    rates = RateParser.parse(File.join(File.dirname(__FILE__), "../data/SAMPLE_RATES.xml"))
    rate_chain = ChainBuilder.build(rates, "USD")

    transactions = TransactionParser.parse(File.join(File.dirname(__FILE__), "../data/SAMPLE_TRANS.csv"))

    sku = "DM1182"
    target_currency = "USD"
    solver = Solver.new(transactions, sku, rate_chain, target_currency)
    solver.solution.should == 134.22
  end
end
