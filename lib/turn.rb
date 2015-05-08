class Turn
  attr_accessor :column, :row, :character, :successful
  def initialize(column, row, character)
    @column = column
    @row = row
    @character = "|#{character}|"
    @successful = false
  end

  def successful?
    successful
  end

  def was_successful
    self.successful = true
  end
end
