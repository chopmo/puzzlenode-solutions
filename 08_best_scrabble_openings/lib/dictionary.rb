require 'json'

class Dictionary
  def self.from_json(json)
    new(json)
  end

  def initialize(json)
    @words = JSON.parse(json)
  end

  attr_reader :words
end
