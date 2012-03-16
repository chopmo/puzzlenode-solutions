require 'word'

describe Word do

  def lcss(s1, s2)
    Word.lcss(s1, s2)
  end

  describe "#lcss" do
    it "handles empty words" do
      lcss("", "").should == ""
    end

    it "handles when first word is empty" do
      lcss("", "foo").should == ""
    end
    
    it "handles when second word is empty" do
      lcss("foo", "").should == ""
    end

    it "handles identical single-letter words" do
      lcss("x", "x").should == "x"
    end

    it "handles longer identical words" do
      lcss("foo", "foo").should == "foo"
    end

    it "handles when w1 is a prefix of w2" do
      lcss("foo", "foobar").should == "foo"
    end
    
    it "handles when w2 is a prefix of w1" do
      lcss("foobar", "foo").should == "foo"
    end

    it "handles when w1 contains a letter not found in w2" do
      lcss("fooXbar", "foobar").should == "foobar"
    end

    it "handles when w2 contains a letter not found in w1" do
      lcss("foobar", "fooXbar").should == "foobar"
    end
  end
end
