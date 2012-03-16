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

      it "handles when first word is empty" do
        lcss("", "foo").should == ""
      end
      
      it "handles when second word is empty" do
        lcss("foo", "").should == ""
      end

      it "handles matching single-letter words" do
        lcss("x", "x").should == "x"
      end
    end

    
  end
end
