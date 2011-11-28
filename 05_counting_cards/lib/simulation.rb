class Simulation
  def self.apply_turn(table, turns, idx, applied_turns)
    return nil if table.nil?
    return table if idx == turns.size

    turn = turns[idx]
    # puts "Applying turn #{idx+1}: #{turn}" if turn.resolutions.size > 1

    turn.resolutions.each do |r|
      # puts "Applying resolution: #{r}"
      applied_turns.push(r)
      result = apply_turn(table.apply(r), turns, idx + 1, applied_turns)
      if result
        return result
      else
        applied_turns.pop
      end
    end

    return nil
  end

end
