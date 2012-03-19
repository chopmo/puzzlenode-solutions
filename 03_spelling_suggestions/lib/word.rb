class Word
  def self.last(s, i)
    s[i..i]
  end

  def self.lcss(s1, s2)
    @memoized ||= {}
    lcss_recursive(s1, s2, s1.size-1, s2.size-1)
  end

  def self.lcss_recursive(s1, s2, i1, i2)
    memoize_result_for([s1, s2, i1, i2]) do
      if i1 == -1 || i2 == -1
        ""
      elsif last(s1, i1) == last(s2, i2)
        lcss_recursive(s1, s2, i1-1, i2-1) + last(s1, i1)
      else
        res1 = lcss_recursive(s1, s2, i1-1, i2)
        res2 = lcss_recursive(s1, s2, i1, i2-1)
        res1.size >= res2.size ? res1 : res2
      end
    end
  end

  def self.memoize_result_for(key)
    @memoized[key] ||= yield
  end

  def self.fix_spelling(wrong, w1, w2)
    lcss(wrong, w1).size > lcss(wrong, w2).size ? w1 : w2
  end
end
