require 'pry'
class Game
  attr_accessor :grid, :turn, :finished, :piece, :square_count, :squares_occupied

  def initialize(piece, grid_size)
    set_piece(piece)
    @grid = make_grid(grid_size)
    @square_count = grid_size * grid_size
    @squares_occupied = 0
    @turn = rand(1..2)
    @finished = false
  end

  def character
    turn == 1 ? "|x|" : "|o|"
  end
 
  def finished?
    finished || out_of_squares?
  end
  
  def out_of_squares?
    if square_count == squares_occupied
      puts "cats game!"
      true
    end
  end
  
  def set_piece(piece)
    @piece = "|#{piece}|"
  end
 
  def make_grid(size)
    rows = []
    size.times do |x|
      cells = []
      size.times do |xx|
        cells << "| |"
      end
      rows << cells
    end
    rows
  end
 
  def display_grid
    grid.each {|x| p x}
  end
  
  def mark_board(x, y)
    x = x - 1
    y = grid.length - y
    unless grid[y][x] == "| |"
      puts "That spot has already been selected" if piece == character
      return
    end
    gr = grid
    gr[y][x] = character
    grid = gr
    if grid[y + 1] && grid[y + 2] && (grid[y + 1][x] == character && grid[y + 2][x] == character)
      self.finished = true
      puts 1
    end
    if grid[y] && grid[y] && (grid[y][x + 1] == character && grid[y][x + 2] == character)
      self.finished = true
      puts 2
    end
    if x != 0 && grid[y] && grid[y] && (grid[y][x - 1] == character && grid[y][x - 2] == character)
      self.finished = true
      puts 3
    end
    if y != 0 && grid[y - 1] && grid[y - 2] && (grid[y - 1][x] == character && grid[y - 2][x] == character)
      self.finished = true
      puts 4
    end
    if grid[y + 1] && grid[y + 2] && (grid[y + 1][x + 1] == character && grid[y + 2][x + 2] == character)
       self.finished = true
       puts 5
    end
    if x != 0 && grid[y + 1] && grid[y + 2] && (grid[y + 1][x - 1] == character && grid[y + 2][x - 2] == character)
      self.finished = true
      puts 6
    end
    if y != 0 && grid[y - 1] && grid[y - 2] && (grid[y - 1][x + 1] == character && grid[y - 2][x + 2] == character)
      self.finished = true
      puts 7
    end
    if y != 0 && x != 0 && grid[y - 1] && grid[y - 2] && (grid[y - 1][x - 1] == character && grid[y - 2][x - 2] == character)
      self.finished = true
      puts 8
    end
    display_grid
    puts character + "just won" if finished
    change_turn
    self.squares_occupied = squares_occupied + 1
  end

  def change_turn
    @turn == 2 ? @turn = 1 : @turn = 2
  end
end
 
piece = nil
grid_size = nil

until piece == "x" || piece == "o"
  puts "do you want to be exes or ohs? x/o"
  piece = gets.chomp
end

until grid_size.to_i > 2
  puts "How large do you want the grid to be?"
  grid_size = gets.chomp
end

game = Game.new(piece, grid_size.to_i)
x = 0
y = 0

until game.finished?
  if game.piece == game.character
    until x.to_i.between?(1, grid_size.to_i) && y.to_i.between?(1, grid_size.to_i)
      puts "enter the cordinate of the x axis you would like to place your spot."
      x = gets.chomp.to_i
      puts "enter the cordinate of the y axis you would like to place your spot."
      y = gets.chomp.to_i
    end
    game.mark_board(x, y)
  else
    x = rand(1..grid_size.to_i)
    y = rand(1..grid_size.to_i)
    game.mark_board(x, y)
  end
    x=0
    y=0
end

puts "Thank you"
