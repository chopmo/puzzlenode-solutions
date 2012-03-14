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

  describe "bankers rounding" do
    let(:rate_chain) { RateChain.new([Rate.new("USD", "DKK", 1.0)]) }
    def bd(s); BigDecimal.new(s); end

    def convert(amount)
      rate_chain.convert(amount, "USD", "DKK")
    end
    
    context "when fraction is 0.005" do

      it "rounds up to even" do
        convert("0.795").should == bd("0.80")
      end
      
      it "rounds down to even" do
        convert("0.565").should == bd("0.56")
      end
    end

    context "otherwise" do
      it "does normal rounding down" do
        convert("0.101").should == bd("0.10")
      end

      it "does normal rounding up" do
        convert("0.108").should == bd("0.11")
      end
    end
  end
  
end
