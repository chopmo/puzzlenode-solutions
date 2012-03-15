class Flight < Struct.new(:from_city, :to_city, :departs, :arrives, :price)
  def to_s
    "Flight #{from_city} (#{departs}) -> #{to_city} (#{arrives}) for #{price}"
  end

end
