class Word
  def initialize(s)
    @data = s.to_s
  end

  def last
    @data[-1]
  end

  def without_last
    @data[0..-2]
  end

  def empty?
    @data.empty?
  end

  def to_s
    @data
  end

  def self.lcss(s1, s2)
    memoize_result_for([s1, s2]) do
      w1 = new(s1)
      w2 = new(s2)

      if w1.empty? || w2.empty?
        ""
      elsif w1.last == w2.last
        lcss(w1.without_last, w2.without_last) + w1.last
      else
        res1 = lcss(w1.without_last, w2)
        res2 = lcss(w1, w2.without_last)
        res1.size >= res2.size ? res1 : res2
      end
    end
  end

  def self.memoize_result_for(key)
    @memoized ||= {}
    @memoized[key] ||= yield
  end


  def self.fix_spelling(wrong, w1, w2)
    lcss(wrong, w1).size > lcss(wrong, w2).size ? w1 : w2
  end

end
