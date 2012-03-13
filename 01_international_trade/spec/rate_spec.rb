require 'rate'

describe Rate do
  
  describe "bankers rounding" do
    let(:rate) { Rate.new("X", "X", 1.0) }

    context "when fraction is 0.5" do

      it "rounds up to even" do
        rate.convert("79.5").should == 80.0
      end
      
      it "rounds down to even" do
        rate.convert("56.5").should == 56.0
      end
    end

    context "otherwise" do
      it "does normal rounding down" do
        rate.convert("10.1").should == 10.0
      end

      it "does normal rounding up" do
        rate.convert("10.8").should == 11.0
      end
    end
  end
end
