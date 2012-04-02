
class Season < Struct.new(:start, :end, :rate)
  def covers?(d)
    start_date = Date.parse("#{d.year}-#{self.start}")
    end_date = Date.parse("#{d.year}-#{self.end}")

    wrapping = end_date < start_date
    if wrapping
      d >= start_date || d <= end_date
    else
      start_date <= d && end_date >= d
    end
  end
end
