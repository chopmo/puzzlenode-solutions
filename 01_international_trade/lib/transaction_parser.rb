require 'csv'

require 'transaction'

class TransactionParser
  def self.parse(filename)
    CSV.read(filename, :headers => true).map { |t|
      sku = t["sku"]
      amount, currency = *t["amount"].split(" ")
      Transaction.new(sku, amount, currency)
    }
  end

end
