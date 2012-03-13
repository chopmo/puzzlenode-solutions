require 'rate'
require 'rate_chain'

describe RateChain do
  it "can be build from an array of rates" do
    rates = [ Rate.new("DKK", "USD", 0), Rate.new("EUR", "DKK", 0) ]

    chain = RateChain.from_rates(rates, "USD")

    # Chain should be EUR => DKK => USD
    chain.supports?("EUR", "DKK").should be_true
    chain.supports?("DKK", "USD").should be_true
    chain.supports?("EUR", "USD").should be_true

    chain.supports?("USD", "DKK").should be_false
    chain.supports?("DKK", "EUR").should be_false
    chain.supports?("USD", "EUR").should be_false
  end
end
