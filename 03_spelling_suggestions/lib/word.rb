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

  def remaining
    @data[@idx..-1]
  end
  
  def distance_to(letter)
    remaining.index(letter) || 999 # What to use in a case like this? 
  end

  def to_s
    s = (" " + @data.split("").join(" ") + "   ")
    s[@idx*2] = "["; s[@idx*2+2] = "]"
    s
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
      else
        if w1.distance_to(w2.letter) < w2.distance_to(w1.letter)
          w1.advance
        else
          w2.advance
        end
      end

      # puts w1
      # puts w2
      # puts "RESULT: " + result
    end
    result
  end

  def self.fix_spelling(wrong, w1, w2)
    lcss(wrong, w1).size > lcss(wrong, w2).size ? w1 : w2
  end

end
