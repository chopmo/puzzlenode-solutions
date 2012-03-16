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

  def can_advance_to?(letter)
    @data[@idx..-1].include?(letter)
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
        if !w2.can_advance_to?(w1.letter)
          w1.advance
        elsif !w1.can_advance_to?(w2.letter)
          w2.advance
        end
      end
    end
    result
  end

end
