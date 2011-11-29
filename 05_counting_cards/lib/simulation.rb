class Simulation

  # Returns the first valid resolution of the turn turns[idx].
  #
  # To find a valid resolution, a recursive call is made for each
  # candidate resolution with the updated table state and idx+1. This
  # means that for the candidate resolution to be valid, a resolution
  # in turns[idx+1] must be valid, which will again make a recursive
  # call etc. etc. 
  #
  # Note that applied_turns is not actually needed to *find* the
  # solution, but without it we would just return the final table
  # state.
  def self.apply_turn(table, turns, idx, applied_turns)
    return nil if table.nil?
    return table if idx == turns.size

    turns[idx].resolutions.each do |r|
      applied_turns.push(r)
      if result = apply_turn(table.apply(r), turns, idx + 1, applied_turns)
        return result
      else
        applied_turns.pop
      end
    end

    # We have tried all resolutions without finding a valid one
    return nil
  end

end
