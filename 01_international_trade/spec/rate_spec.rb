require 'rate'

describe Rate do
  
  describe "bankers rounding" do
    let(:rate) { Rate.new("X", "X", 1.0) }
    def bd(s); BigDecimal.new(s); end

    context "when fraction is 0.005" do

      it "rounds up to even" do
        rate.convert("0.795").should == bd("0.80")
      end
      
      it "rounds down to even" do
        rate.convert("0.565").should == bd("0.56")
      end
    end

    context "otherwise" do
      it "does normal rounding down" do
        rate.convert("0.101").should == bd("0.10")
      end

      it "does normal rounding up" do
        rate.convert("0.108").should == bd("0.11")
      end
    end
  end
end
