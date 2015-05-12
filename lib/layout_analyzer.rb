require 'ruby-try'
require 'pry'

class LayoutAnalyzer
  attr_reader :layout, :row, :column

  def initialize(layout)
    @layout = layout
  end

  def create_turn(character)
    best_turn = nil
    layout.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        turn = Turn.new(column_index, row_index, character)
        next if cell.marked?
        best_turn = turn
        if three_in_a_row?(row_index, column_index)
          puts "#{character}'s wins" 
          return turn
        end 
      end
    end
    best_turn
  end

  def three_in_a_row?(row, column)
    set_last_last_turn(row, column)
    lean_backward || lean_forward ||
    horizontal || vertical || up_left || 
    straight_down || straight_right || 
    straight_left || straight_up || 
    down_right || down_left || up_right
  end

  private

  def turn_cell
    layout[row][column].space
  end

  def set_last_last_turn(row, column)
    @row = row
    @column = column
  end

  def two_rows_up?
    row - 2 >= 0
  end
  
  def one_row_up
    layout[row - 1]
  end
  
  def one_column_lower
    column + 1
  end
  
  def two_rows_up
    layout[row - 2]
  end
  
  def two_columns_left?
    column - 2 >= 0
  end

  def one_column_left?
    column != 0
  end

  def one_row_up?
    row != 0
  end

  def one_row_lower
    layout[row + 1]
  end

  def two_rows_lower
    layout[row + 2]
  end
  
  def at_one_column_right
    layout[row][one_column_lower].try(:space)
  end

  def at_two_columns_right
    layout[row][column + 2].try(:space)
  end
  
  def at_one_row_lower_and_one_column_right
    one_row_lower[one_column_lower].try(:space)
  end
  
  def at_one_row_lower_and_one_column_left
    one_row_lower[column - 1].try(:space)
  end
  
  def at_one_row_up
    one_row_up[column].try(:space)
  end
  
  def at_two_rows_up
    two_rows_up[column].try(:space)
  end
  
  def at_two_rows_lower_and_two_columns_left
    two_rows_lower[column - 2].try(:space)
  end

  def at_one_column_left
    layout[row][column - 1].try(:space)
  end
  
  def at_one_row_up_and_one_column_lower
    one_row_up[one_column_lower].try(:space)
  end
  
  def at_two_rows_up_and_two_columns_up
    two_rows_up[column - 2].try(:space)
  end

  def at_one_row_lower
    one_row_lower[column].try(:space)
  end

  def at_one_row_up_and_one_column_left
    one_row_up[column - 1].try(:space)
  end

  def at_two_rows_up_and_two_columns_right
    two_rows_up[column + 2].try(:space)
  end

  def at_two_rows_lower_and_two_columns_right
    two_rows_lower[column + 2].try(:space)
  end
  
  def at_two_columns_left
    layout[row][column - 2].try(:space)
  end
  
  def at_two_rows_lower
    two_rows_lower[column].try(:space)
  end

  def straight_up
    two_rows_up? && one_row_up && two_rows_up && 
    [at_one_row_up, turn_cell, at_two_rows_up].uniq.length == 1
  end

  def straight_left
    two_columns_left? && layout[row] && layout[row] &&
    [at_one_column_left, turn_cell, at_two_columns_left].uniq.length == 1
  end

  def down_right
    one_row_lower && two_rows_lower &&
    [at_one_row_lower_and_one_column_right, turn_cell, at_two_rows_lower_and_two_columns_right].uniq.length == 1
  end

  def down_left
    two_columns_left? && one_row_lower && two_rows_lower &&
    [at_one_row_lower_and_one_column_left, turn_cell, at_two_rows_lower_and_two_columns_left].uniq.length == 1
  
  end

  def up_right
    two_rows_up? && one_row_up && two_rows_up &&
    [at_one_row_up_and_one_column_lower, turn_cell, at_two_rows_up_and_two_columns_right].uniq.length == 1
  
  end

  def up_left
    two_rows_up? && two_columns_left? && one_row_up && two_rows_up &&
    [at_one_row_up_and_one_column_left, turn_cell, at_two_rows_up_and_two_columns_up].uniq.length == 1
  
  end

  def horizontal
    one_column_left? &&
    [at_one_column_right, turn_cell, at_one_column_left].uniq.length == 1
  
  end

  def lean_forward
    one_column_left? && one_row_up? && one_row_lower &&
    [at_one_row_up_and_one_column_lower, turn_cell, at_one_row_lower_and_one_column_left].uniq.length == 1
  
  end

  def lean_backward
    one_column_left? && one_row_up? && one_row_lower &&
    [at_one_row_up_and_one_column_left, turn_cell, at_one_row_lower_and_one_column_right].uniq.length == 1
  end

  def vertical
    one_row_up? && one_row_lower && one_row_up &&
    [at_one_row_lower, turn_cell, at_one_row_up].uniq.length == 1
  end

  def straight_right
    [at_one_column_right, turn_cell, at_two_columns_right].uniq.length == 1
  end

  def straight_down
    one_row_lower && two_rows_lower &&
    [at_one_row_lower, turn_cell, at_two_rows_lower].uniq.length == 1
  end
end