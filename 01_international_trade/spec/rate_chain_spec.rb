require 'rate'
require 'rate_chain'
require 'rate_parser'

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

  it "can build a more complex chain" do
    rate_xml = open(File.join(File.dirname(__FILE__), "../data/RATES.xml")).read
    rates = RateParser.parse(rate_xml)
    chain = RateChain.from_rates(rates, "USD")

    chain.supports?("EUR", "USD").should be_true
    chain.supports?("AUD", "USD").should be_true
    chain.supports?("CAD", "USD").should be_true
  end

  it "can convert an amount" do
    rates = [ Rate.new("DKK", "USD", 1.5), Rate.new("EUR", "DKK", 1.5) ]
    chain = RateChain.from_rates(rates, "USD")
    chain.convert(100, "EUR", "USD").should == 225.0
  end
end
