require './lib/game.rb'

user_piece = nil
grid_size = nil

until user_piece == "x" || user_piece == "o"
  puts "do you want to be exes or ohs? x/o"
  user_piece = gets.chomp
end

until grid_size.to_i > 2
  puts "How large do you want the grid to be?"
  grid_size = gets.chomp
end

game = Game.new(user_piece, grid_size.to_i)

game.start_game

puts "Thank you"