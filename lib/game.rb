require_relative 'grid.rb'
require_relative 'turn.rb'
require 'pry'

class Game
  attr_accessor :grid_size, :grid, :finished, :user_piece, :current_player

  def initialize(user_piece, grid_size)
    @grid_size = grid_size
    @grid = Grid.new(grid_size)
    @user_piece = user_piece
    @current_player = ["o", "x"].sample
    @finished = false
  end

  def display_board
    grid.display_board
  end

  def finished?
    finished
  end

  def change_turn
    self.current_player = ["x","o"].reject {|e| e == current_player}.first
  end

  def generate_user_turn
    validated = nil
    until validated
      puts "enter the cordinate of the x axis you would like to place your spot."
      x = gets.chomp.to_i
      puts "enter the cordinate of the y axis you would like to place your spot."
      y = gets.chomp.to_i
      validated = validate_turn(x, y)
    end
    Turn.new(x - 1, grid_size - y, current_player)
  end

  def generate_computer_turn
    validated = nil
    until validated
      x = rand(1..grid_size.to_i)
      y = rand(1..grid_size.to_i)
      validated = validate_turn(x, y)
    end
    Turn.new(x - 1, grid_size - y, current_player)
  end
  
  def validate_turn(x, y)
    if !x.to_i.between?(1, grid_size.to_i) || !y.to_i.between?(1, grid_size.to_i)
      puts "Invalid Cordinates"
      return false
    elsif grid.grid[grid_size - y][x - 1].marked?
      puts "That spot has already been selected"
      return false
    else
      true
    end
  end

  def finished?(turn)
    grid.check_board?(turn)
  end

  def start_game
    turn = nil
    until turn && grid.board_completed?(turn)
      if user_piece == current_player
        turn = generate_user_turn
      else
        turn = generate_computer_turn
      end
      until turn.successful?
        grid.mark(turn)
      end
      change_turn
    end
  end
end

