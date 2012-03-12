module Wires
  class DiagramSplitter
    def self.split(diagram)
      result = [""]
      diagram.lines.each do |l|
        if l.strip.empty?
          result << ""
        else
          result.last.replace(result.last + l)
        end
      end
      result
    end
  end
end
