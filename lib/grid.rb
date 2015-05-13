require_relative 'cell.rb'
require_relative 'layout_analyzer.rb'
require 'pry'

class Grid
  attr_reader :layout
  
  def initialize(layout_size)
    @square_count = layout_size * layout_size
    make_layout(layout_size)
    @squares_occupied = 0
  end

  def board_completed?(row, column, character)
    if game_won?(row, column)
      puts "#{character}'s wins" 
    elsif cats_game?
      puts "cats game!"
    else
      return false
    end
    true
  end

  def display
    layout.each {|x| p x.reduce(""){ |a, e| a + e.space } }
    puts "\n\n\n"
  end

  def mark(turn)
    cell = layout[turn.row][turn.column]
    if cell.marked?
      puts "\n\n\n"
      puts "That spot has already been selected"
      false
    else
      cell.mark(turn.character)
      self.squares_occupied +=   1
      true
    end
  end

  private

  attr_accessor :squares_occupied
  attr_reader :square_count

  def make_layout(size)
    rows = []
    size.times do
      cells = []
      size.times do
        cells << Cell.new
      end
      rows << cells
    end
    @layout = rows
  end
  
  def cats_game?
    square_count == squares_occupied
  end

  def game_won?(row, column)
    grid_analyzer.three_in_a_row?(row, column)
  end

  def grid_analyzer
    LayoutAnalyzer.new(layout)
  end
end
