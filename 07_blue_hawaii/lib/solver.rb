require 'date'
require 'rental'

class Solver
  def self.solve(input, rentals_json)
    from_date, to_date = input.split(" - ").map { |s| Date.parse(s) }
    rentals = Rental.all_from_json(rentals_json)

    rentals.map { |rental|
      formatted_price = sprintf("%.2f", rental.price(from_date, to_date))
      "#{rental.name}: $#{formatted_price}"
    }.join("\n")
  end
end
