require 'json'

class Dictionary < Struct.new(:words)
  def self.from_json(json)
    new(JSON.parse(json))
  end

  def reject_unplacable(tileset)
    words.select! { |w| tileset.can_form?(w) }
  end
end
