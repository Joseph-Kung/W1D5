require_relative "./lib/00_tree_node.rb"

class KnightPathFinder
  SHIFTS = [[-2,-1], [-1,-2], [1,-2], [2,-1], [-2,1], [-1,2], [1,2], [2,1]]

  attr_reader :root_node, :visited_positions

  def initialize(pos)
    @root_node = PolyTreeNode.new(pos)
    @visited_positions = [pos]
    build_move_tree
  end

  def build_move_tree
    queue = [@root_node]
    until queue.empty?
      node = queue.first
      positions = new_move_positions(node.value)
      positions.each do |position|
        node.add_child(PolyTreeNode.new(position))
      end
      queue += node.children
      queue.shift
    end
    @root_node
  end

  def find_path(end_pos)
    node = @root_node.bfs(end_pos)
    trace_path_back(node)
  end

  def trace_path_back(node)
    path = []
    start_pos = @root_node.value

    until node.value == start_pos
      path << node.value
      node = node.parent
    end

    path << start_pos
    return path.reverse
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
end

class Array
  def valid_move?
    x , y = self
    return false if x < 0 || x > 7 || y < 0 || y > 7
    true
  end
end
