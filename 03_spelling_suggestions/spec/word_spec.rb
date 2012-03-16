require 'word'

describe Word do

  def lcss(s1, s2)
    Word.lcss(s1, s2)
  end

  describe "#lcss" do
    describe "trivial cases" do
      it "handles empty words" do
        lcss("", "").should == ""
      end
    end
    
  end
end
