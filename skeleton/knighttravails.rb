require_relative "./lib/00_tree_node.rb"

class KnightPathFinder
  SHIFTS = [[-2,-1], [-1,-2], [1,-2], [2,-1], [-2,1], [-1,2], [1,2], [2,1]]

  def initialize(pos)
    @root_node = PolyTreeNode.new(pos)
    @visited_positions = [pos]
    build_move_tree
  end

  def build_move_tree

  end

  def new_move_positions(pos)
    new_moves = KnightPathFinder.valid_moves(pos).reject {|move| @visited_positions.include?(move)}
    @visited_positions += new_moves
    return new_moves
  end

  def self.valid_moves(pos)
    x , y = pos
    moves = []

    SHIFTS.each do |shift|
      x_shift , y_shift = shift

      moves << [x + x_shift, y + y_shift]
    end
    moves.select {|move| move.valid_move?}
  end

  # def valid_move?(pos)
  #   x , y = pos
  #   return false if x < 0 || x > 7 || y < 0 || y > 7
  #   true
  # end

end

class Array
  def valid_move?
    x , y = self
    return false if x < 0 || x > 7 || y < 0 || y > 7
    true
  end
end
