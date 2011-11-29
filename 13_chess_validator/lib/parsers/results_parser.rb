class ResultsParser
  def initialize(text)
    @text = text
  end

  def parse
    @text.lines.map(&:strip).map do |line|
      case line
      when /^LEGAL/
        true
      when /^ILLEGAL/
        false
      else
        nil
      end
    end.compact
  end
end
