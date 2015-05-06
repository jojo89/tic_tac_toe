require 'pry'
class Game
  attr_accessor :grid, :turn, :finished
 
  def initialize(piece, grid_size, turn)
    @piece = piece
    @grid = make_grid(grid_size)
    @turn = turn
    @finished = false
  end
  
  def character
    turn == true ? "|x|" : "|o|"
  end
 
  def finished?
    finished
  end
 
  def make_grid(size)
    array = []
    size.times do |x|
      arra=[]
      size.times do |xx|
        arra << "| |"
      end
      array << arra
    end
    array
  end
 
  def display_grid
    grid.each {|x| p x}
  end
  
  def mark_board(x, y)
    x = x.to_i - 1
    y = grid.length - y.to_i
    
    unless grid[y][x] == "| |"
      puts "That spot has already been selected" 
      return
    end
    gr = grid
    gr[y][x] = character
    grid = gr
    cell = gr[y][x]
    self.finished = true if grid[y + 1] && grid[y + 2] && (grid[y + 1][x] == cell && grid[y + 2][x] == cell)
    self.finished = true if grid[y] && grid[y] && (grid[y][x + 1] == cell && grid[y][x + 2] == cell)
    self.finished = true if x != 0 && grid[y] && grid[y] && (grid[y][x - 1] == cell && grid[y][x - 2] == cell)
    self.finished = true if y != 0 && grid[y - 1] && grid[y - 2] && (grid[y - 1][x] == cell && grid[y - 2][x] == cell)
    self.finished = true if grid[y + 1] && grid[y + 2] && (grid[y + 1][x + 1] == cell && grid[y + 2][x + 2] == cell)
    self.finished = true if x != 0 && grid[y + 1] && grid[y + 2] && (grid[y + 1][x - 1] == cell && grid[y + 2][x - 2] == cell)
    self.finished = true if y != 0 && grid[y - 1] && grid[y - 2] && (grid[y - 1][x + 1] == cell && grid[y - 2][x + 2] == cell)
    self.finished = true if y != 0 && x != 0 && grid[y - 1] && grid[y - 2] && (grid[y - 1][x - 1] == cell && grid[y - 2][x - 2] == cell)
    puts "done" if self.finished
    change_turn
    display_grid
  end
  
  def change_turn
    turn ? @turn = false : @turn = true
  end
end
 
game = Game.new("x", 3, true)
 
puts "do you want to be exes? y/n"
input = gets.chomp
 
until input == "y" || input == "n"
  puts "do you want to be exes? y/n"
  input = gets.chomp
end
 
until game.finished?
  puts "enter the cordinate of the x axis you would like to place your spot."
  x = gets.chomp
  puts "enter the cordinate of the y axis you would like to place your spot."
  y = gets.chomp
  game.mark_board(x, y)
end
 
puts "Thank you"