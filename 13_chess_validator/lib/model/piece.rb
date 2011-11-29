class Piece
  attr_reader :identity

  def initialize(identity)
    @identity = identity
  end
  
  def rank
    @identity[1]
  end

  def color
    @identity[0]
  end

  def capturable?
    !king?
  end

  def king?
    rank == "K"
  end
  
  def can_capture?(other)
    other.capturable? && color != other.color
  end
end
