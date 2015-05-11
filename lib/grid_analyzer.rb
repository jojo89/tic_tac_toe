require 'ruby-try'
require 'pry'

class GridAnalyzer
  attr_reader :layout, :last_turn

  def initialize(layout)
    @layout = layout
  end

  def three_in_a_row?(last_turn)
    set_last_last_turn(last_turn)
    lean_backward || lean_forward ||
    horizontal || vertical || up_left || 
    straight_down || straight_right || 
    straight_left || straight_up || 
    down_right || down_left || up_right
  end

  private

  def set_last_last_turn(last_turn)
    @last_turn = last_turn
  end

  def two_rows_up?
    last_turn.row - 2 >= 0
  end
  
  def one_row_up
    layout[last_turn.row - 1]
  end
  
  def one_column_lower
    last_turn.column + 1
  end
  
  def two_rows_up
    layout[last_turn.row - 2]
  end
  
  def two_columns_left?
    last_turn.column - 2 >= 0
  end

  def one_column_left?
    last_turn.column != 0
  end

  def one_row_up?
    last_turn.row != 0
  end

  def one_row_lower
    layout[last_turn.row + 1]
  end

  def two_rows_lower
    layout[last_turn.row + 2]
  end
  
  def at_one_column_right
    layout[last_turn.row][one_column_lower].try(:space)
  end

  def at_two_columns_right
    layout[last_turn.row][last_turn.column + 2].try(:space)
  end
  
  def at_one_row_lower_and_one_column_right
    one_row_lower[one_column_lower].try(:space)
  end
  
  def at_one_row_lower_and_one_column_left
    one_row_lower[last_turn.column - 1].try(:space)
  end
  
  def at_one_row_up
    one_row_up[last_turn.column].try(:space)
  end
  
  def at_two_rows_up
    two_rows_up[last_turn.column].try(:space)
  end
  
  def at_two_rows_lower_and_two_columns_left
    two_rows_lower[last_turn.column - 2].try(:space)
  end

  def at_one_column_left
    layout[last_turn.row][last_turn.column - 1].try(:space)
  end
  
  def at_one_row_up_and_one_column_lower
    one_row_up[one_column_lower].try(:space)
  end
  
  def at_two_rows_up_and_two_columns_up
    two_rows_up[last_turn.column - 2].try(:space)
  end

  def at_one_row_lower
    one_row_lower[last_turn.column].try(:space)
  end

  def at_one_row_up_and_one_column_left
    one_row_up[last_turn.column - 1].try(:space)
  end

  def at_two_rows_up_and_two_columns_right
    two_rows_up[last_turn.column + 2].try(:space)
  end

  def at_two_rows_lower_and_two_columns_right
    two_rows_lower[last_turn.column + 2].try(:space)
  end

  def straight_up
    two_rows_up? && one_row_up && two_rows_up && 
    (at_one_row_up == last_turn.character && at_two_rows_up == last_turn.character)
  end

  def straight_left
    two_columns_left? && layout[last_turn.row] && layout[last_turn.row] &&
    (at_one_column_left == last_turn.character && layout[last_turn.row][last_turn.column - 2] == last_turn.character)
  end

  def down_right
    one_row_lower && two_rows_lower &&
    (at_one_row_lower_and_one_column_right == last_turn.character && at_two_rows_lower_and_two_columns_right == last_turn.character)
  end

  def down_left
    two_columns_left? && one_row_lower && two_rows_lower &&
    (at_one_row_lower_and_one_column_left == last_turn.character && at_two_rows_lower_and_two_columns_left == last_turn.character)
  end

  def up_right
    two_rows_up? && one_row_up && two_rows_up &&
    (at_one_row_up_and_one_column_lower == last_turn.character && at_two_rows_up_and_two_columns_right == last_turn.character)
  end

  def up_left
    two_rows_up? && two_columns_left? && one_row_up && two_rows_up &&
    (at_one_row_up_and_one_column_left == last_turn.character && at_two_rows_up_and_two_columns_up == last_turn.character)
  end

  def horizontal
    one_column_left? &&
    (at_one_column_right == last_turn.character && at_one_column_left == last_turn.character)
  end

  def lean_forward
    one_column_left? && one_row_up? && one_row_lower &&
    (at_one_row_up_and_one_column_lower == last_turn.character && at_one_row_lower_and_one_column_left == last_turn.character)
  end

  def lean_backward
    one_column_left? && one_row_up? && one_row_lower &&
    (at_one_row_up_and_one_column_left == last_turn.character && at_one_row_lower_and_one_column_right == last_turn.character)
  end

  def vertical
    one_row_up? && one_row_lower && one_row_up &&
    (at_one_row_lower == last_turn.character && at_one_row_up == last_turn.character)
  end

  def straight_right
     at_one_column_right == last_turn.character && at_two_columns_right == last_turn.character
  end

  def straight_down
    one_row_lower && two_rows_lower &&
    (at_one_row_lower == last_turn.character && two_rows_lower[last_turn.column] == last_turn.character)
  end
end