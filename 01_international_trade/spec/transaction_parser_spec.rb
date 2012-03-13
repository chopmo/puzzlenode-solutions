require 'transaction_parser'

describe TransactionParser do
  it "reads a CSV file of transactions and returns each in a struct" do
    transactions = TransactionParser.parse(File.join(File.dirname(__FILE__), "../data/SAMPLE_TRANS.csv"))
    t = transactions.first
    
    t.sku.should == "DM1210"
    t.amount.should == "70.00"
    t.currency.should == "USD"
  end
end
