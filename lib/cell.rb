class Cell
  attr_accessor :space

  def initialize
    @space = "| |"
  end

  def mark(space)
    @space = space
  end

  def marked?
    space != "| |"
  end
end
