require_relative 'grid.rb'
require_relative 'turn.rb'
require 'pry'

class Game
  def initialize(user_piece, grid_size)
    @grid = Grid.new(grid_size)
    @user_piece = user_piece
    @current_player = ["o", "x"].sample
  end

  def start_game
    turn = nil
    until turn && finished?(turn.row, turn.column)
      if user_piece == current_player
        turn = generate_user_turn
      else
        turn = generate_computer_turn
      end
      until turn.successful?
        grid.mark(turn)
      end
      display_grid
      change_player
    end
  end

  private

  attr_accessor :grid, :current_player
  attr_reader :user_piece

  def display_grid
    grid.display
  end

  def grid_size
    grid.layout.length
  end

  def change_player
    self.current_player = ["x","o"].reject {|e| e == current_player}.first
  end

  def opposing_player
    ["x","o"].reject {|e| e == current_player}.first
  end

  def generate_user_turn
    validated = nil
    until validated
      puts "enter the cordinate of the x axis you would like to place your spot."
      x = gets.chomp.to_i
      puts "enter the cordinate of the y axis you would like to place your spot."
      y = gets.chomp.to_i
      validated = validate_cordinates(x, y)
    end
    Turn.new(x - 1, grid_size - y, current_player)
  end

  def generate_computer_turn
    LayoutAnalyzer.new(grid.layout).create_turn(current_player)
  end
  
  def validate_cordinates(x, y)
    if !x.to_i.between?(1, grid_size.to_i) || !y.to_i.between?(1, grid_size.to_i)
      puts "Invalid Cordinates"
      return false
    elsif grid.layout[grid_size - y][x - 1].marked?
      puts "That spot has already been selected"
      return false
    else
      true
    end
  end

  def finished?(row, column)
    grid.board_completed?(row, column)
  end
end

