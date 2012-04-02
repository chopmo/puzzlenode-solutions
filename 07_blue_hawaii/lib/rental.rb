require 'json'
require 'season'

class Rental
  attr_accessor :name, :cleaning_fee, :seasons

  def self.all_from_json(json)
    JSON.parse(json).map { |h| from_hash(h) }
  end

  def self.from_hash(h)
    rental = new
    rental.name = h["name"]
    if h["cleaning fee"]
      rental.cleaning_fee = parse_amount(h["cleaning fee"])
    end
    
    (h["seasons"] || []).each do |s|
      season_data = s.values[0]
      rental.seasons << Season.new(season_data["start"],
                                   season_data["end"],
                                   parse_amount(season_data["rate"]))
    end

    if rental.seasons.empty?
      rental.seasons << Season.new("01-01", "12-31", parse_amount(h["rate"]))
    end

    rental
  end

  def initialize
    @seasons = []
    @cleaning_fee = 0
  end

  def price(from_date, to_date)
    amount = 0
    d = from_date
    while d < to_date
      season = find_season(d)
      amount += season.rate
      d += 1
    end

    amount += cleaning_fee
    
    add_sales_tax(amount)
  end

  def find_season(d)
    seasons.first
  end
  
  def add_sales_tax(amount)
    amount * 1.0411416
  end

  # Parse an amount like $123
  def self.parse_amount(s)
    s[1..-1].to_i
  end
end
