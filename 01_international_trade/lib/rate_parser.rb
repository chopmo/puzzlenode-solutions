require 'nokogiri'

require 'rate'

class RateParser
  def self.parse(xml_file)
    xml = open(xml_file).read
    rates = []
    doc = Nokogiri::XML(xml)
    doc.css("rate").each do |rate_node|
      from = rate_node.css("from").inner_text
      to = rate_node.css("to").inner_text
      conversion = rate_node.css("conversion").inner_text.to_f
      rates << Rate.new(from, to, conversion)
    end
    rates
  end
end
