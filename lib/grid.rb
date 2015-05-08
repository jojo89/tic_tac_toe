require_relative 'cell.rb'
require 'pry'
require 'ruby-try'

class Grid
  attr_reader :layout
  
  def initialize(layout_size)
    @square_count = layout_size * layout_size
    make_layout(layout_size)
    @squares_occupied = 0
  end

  def board_completed?(turn)
    if game_won?(turn)
      puts "#{turn.character}'s wins" 
    elsif square_count == squares_occupied
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
    else
      cell.mark(turn.character)
      turn.was_successful
      self.squares_occupied +=   1
    end
  end

  private

  attr_accessor :squares_occupied
  attr_reader :square_count

  def make_layout(size)
    rows = []
    size.times do |x|
      cells = []
      size.times do |xx|
        cells << Cell.new
      end
      rows << cells
    end
    @layout = rows
  end

  def straight_up(turn)
    turn.row - 2 >= 0 && layout[turn.row - 1] && layout[turn.row - 2] && (layout[turn.row - 1][turn.column].try(:space) == turn.character && layout[turn.row - 2][turn.column].try(:space) == turn.character)
  end

  def straight_left(turn)
    turn.column - 2 >= 0 && layout[turn.row] && layout[turn.row] && (layout[turn.row][turn.column - 1].try(:space) == turn.character && layout[turn.row][turn.column - 2].try(:space) == turn.character)
  end

  def down_right(turn)
    layout[turn.row + 1] && layout[turn.row + 2] && (layout[turn.row + 1][turn.column + 1].try(:space) == turn.character && layout[turn.row + 2][turn.column + 2].try(:space) == turn.character)
  end

  def down_left(turn)
    turn.column - 2 >= 0 && layout[turn.row + 1] && layout[turn.row + 2] && (layout[turn.row + 1][turn.column - 1].try(:space) == turn.character && layout[turn.row + 2][turn.column - 2].try(:space) == turn.character)
  end

  def up_right(turn)
    turn.row - 2 >= 0 && layout[turn.row - 1] && layout[turn.row - 2] && (layout[turn.row - 1][turn.column + 1].try(:space) == turn.character && layout[turn.row - 2][turn.column + 2].try(:space) == turn.character)
  end

  def up_left(turn)
    turn.row - 2 >= 0 && turn.column - 2 >= 0 && layout[turn.row - 1] && layout[turn.row - 2] && (layout[turn.row - 1][turn.column - 1].try(:space) == turn.character && layout[turn.row - 2][turn.column - 2].try(:space) == turn.character)
  end

  def horizontal(turn)
    turn.column != 0 && layout[turn.row] && layout[turn.row] && (layout[turn.row][turn.column + 1].try(:space) == turn.character && layout[turn.row][turn.column - 1].try(:space) == turn.character)
  end

  def lean_forward(turn)
    turn.column != 0 && turn.row != 0 && layout[turn.row] && layout[turn.row + 1] && (layout[turn.row - 1][turn.column + 1].try(:space) == turn.character && layout[turn.row + 1][turn.column - 1].try(:space) == turn.character)
  end

  def lean_backward(turn)
    turn.column != 0 && turn.row != 0 && layout[turn.row] && layout[turn.row + 1] && (layout[turn.row - 1][turn.column - 1].try(:space) == turn.character && layout[turn.row + 1][turn.column + 1].try(:space) == turn.character)
  end

  def vertical(turn)
    turn.row != 0 && layout[turn.row + 1] && layout[turn.row - 1] && (layout[turn.row + 1][turn.column].try(:space) == turn.character && layout[turn.row - 1][turn.column].try(:space) == turn.character)
  end

  def straight_right(turn)
    layout[turn.row] && layout[turn.row] && (layout[turn.row][turn.column + 1].try(:space) == turn.character && layout[turn.row][turn.column + 2].try(:space) == turn.character)
  end

  def straight_down(turn)
    layout[turn.row + 1] && layout[turn.row + 2] && (layout[turn.row + 1][turn.column].try(:space) == turn.character && layout[turn.row + 2][turn.column].try(:space) == turn.character)
  end

  def game_won?(turn)
    lean_backward(turn) || lean_forward(turn) ||
    horizontal(turn) || vertical(turn) || up_left(turn) || 
    straight_down(turn) || straight_right(turn) || 
    straight_left(turn) || straight_up(turn) || 
    down_right(turn) || down_left(turn) || up_right(turn)
  end
end
