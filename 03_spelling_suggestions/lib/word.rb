class Word
  def initialize(s)
    @data = s
    @idx = 0
  end

  def done?
    @idx >= @data.size
  end

  def advance
    @idx += 1
  end

  def letter
    @data[@idx]
  end


  def self.lcss(s1, s2)
    w1 = new(s1)
    w2 = new(s2)

    result = ""

    until w1.done? || w2.done?
      if w1.letter == w2.letter
        result += w1.letter
        w1.advance
        w2.advance
      end
    end
    result
  end

end
