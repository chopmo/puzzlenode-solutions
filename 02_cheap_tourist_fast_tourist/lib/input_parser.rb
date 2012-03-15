require 'test_case_parser'

class InputParser
  def self.parse(text)
    test_case_paragraphs = text.split(/^$/).drop(1)
    test_case_paragraphs.map { |para|
      TestCaseParser.parse(para.gsub(/^\n/, ''))
    }
  end
end
