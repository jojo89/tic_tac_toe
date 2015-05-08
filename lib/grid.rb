require_relative 'cell.rb'
require 'pry'
require 'ruby-try'

class Grid
  attr_accessor :grid, :grid_size, :squares_occupied, :square_count

  def initialize(grid_size)
    @grid_size = grid_size
    make_grid(grid_size)
    @square_count = grid_size * grid_size
    @squares_occupied = 0
  end

  def make_grid(size)
    rows = []
    size.times do |x|
      cells = []
      size.times do |xx|
        cells << Cell.new
      end
      rows << cells
    end
    @grid = rows
  end
  
  def display_grid
    grid.each {|x| p x.reduce(""){ |a, e| a + e.space } }
    p "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  end

  def straight_up(turn)
    turn.row - 2 >= 0 && grid[turn.row - 1] && grid[turn.row - 2] && (grid[turn.row - 1][turn.column].try(:space) == turn.character && grid[turn.row - 2][turn.column].try(:space) == turn.character)
  end

  def straight_left(turn)
    turn.column - 2 >= 0 && grid[turn.row] && grid[turn.row] && (grid[turn.row][turn.column - 1].try(:space) == turn.character && grid[turn.row][turn.column - 2].try(:space) == turn.character)
  end

  def down_right(turn)
    grid[turn.row + 1] && grid[turn.row + 2] && (grid[turn.row + 1][turn.column + 1].try(:space) == turn.character && grid[turn.row + 2][turn.column + 2].try(:space) == turn.character)
  end

  def down_left(turn)
    turn.column - 2 >= 0 && grid[turn.row + 1] && grid[turn.row + 2] && (grid[turn.row + 1][turn.column - 1].try(:space) == turn.character && grid[turn.row + 2][turn.column - 2].try(:space) == turn.character)
  end

  def up_right(turn)
    turn.row - 2 >= 0 && grid[turn.row - 1] && grid[turn.row - 2] && (grid[turn.row - 1][turn.column + 1].try(:space) == turn.character && grid[turn.row - 2][turn.column + 2].try(:space) == turn.character)
  end

  def up_left(turn)
    turn.row - 2 >= 0 && turn.column - 2 >= 0 && grid[turn.row - 1] && grid[turn.row - 2] && (grid[turn.row - 1][turn.column - 1].try(:space) == turn.character && grid[turn.row - 2][turn.column - 2].try(:space) == turn.character)
  end

  def horizontal(turn)
    turn.column != 0 && grid[turn.row] && grid[turn.row] && (grid[turn.row][turn.column + 1].try(:space) == turn.character && grid[turn.row][turn.column - 1].try(:space) == turn.character)
  end

  def lean_forward(turn)
    turn.column != 0 && turn.row != 0 && grid[turn.row] && grid[turn.row] && grid[turn.row + 1] && (grid[turn.row - 1][turn.column + 1].try(:space) == turn.character && grid[turn.row + 1][turn.column - 1].try(:space) == turn.character)
  end

  def lean_backward(turn)
    turn.column != 0 && turn.row != 0 && grid[turn.row] && grid[turn.row] && (grid[turn.row - 1][turn.column + 1].try(:space) == turn.character && grid[turn.row + 1][turn.column - 1].try(:space) == turn.character)
  end

  def vertical(turn)
    turn.row != 0 && grid[turn.row + 1] && grid[turn.row - 1] && (grid[turn.row + 1][turn.column].try(:space) == turn.character && grid[turn.row - 1][turn.column].try(:space) == turn.character)
  end

  def straight_right(turn)
    grid[turn.row] && grid[turn.row] && (grid[turn.row][turn.column + 1].try(:space) == turn.character && grid[turn.row][turn.column + 2].try(:space) == turn.character)
  end

  def straight_down(turn)
    grid[turn.row + 1] && grid[turn.row + 2] && (grid[turn.row + 1][turn.column].try(:space) == turn.character && grid[turn.row + 2][turn.column].try(:space) == turn.character)
  end

  def board_completed?(turn)
    if straight_down(turn)
      puts "straight down #{turn.character} wins" 
      return true
    end
    if straight_right(turn)
      puts "straight right #{turn.character} wins" 
      return true
    end
    if straight_left(turn)
      puts "straight left #{turn.character} wins" 
      return true
    end
    if straight_up(turn)
      puts "straight up #{turn.character} wins" 
      return true
    end
    if down_right(turn)
      puts " down right #{turn.character} wins" 
      return true
    end
    if down_left(turn)
      puts "down left #{turn.character} wins" 
      return true
    end
    if up_right(turn)
      puts "up right #{turn.character} wins" 
      return true
    end
    if up_left(turn)
      puts "up left #{turn.character} wins" 
      return true
    end
    if vertical(turn)
      puts "upright  #{turn.character} wins" 
      return true
    end
    if horizontal(turn)
      puts "horizon #{turn.character} wins" 
      return true
    end
    if lean_forward(turn)
      puts "lean forward #{turn.character} wins"
      return true
    end
    if lean_backward(turn)
      puts "lean backward #{turn.character} wins" 
      return true
    end
    if square_count == squares_occupied
      puts "cats game!"
      return true
    end
    false
  end

  def mark(turn)
    gr = grid
    cell = gr[turn.row][turn.column]
    if cell.marked?
      puts "That spot has already been selected"
    else
      cell.mark(turn.character)
      grid = gr
      turn.was_successful
      display_grid
      self.squares_occupied = squares_occupied + 1
    end
  end
end
