require 'byebug'

class PolyTreeNode

  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
      old_parent = self.parent
      new_parent = node

      if new_parent.nil?
        old_parent.children.delete(self)
      elsif new_parent.children.include?(self) == false
        old_parent.children.delete(self) unless old_parent.nil?
        new_parent.children << self
      end

      @parent = new_parent
  end

  def add_child(node)
    unless self.children.include?(node)
      self.children << node
      node.parent = self
    end
  end

  def remove_child(node)
    self.children.delete(node)
    node.parent = nil
  end

  def dfs(target)
    return self if self.value == target
    return nil if self.children.empty?

    self.children.each do |child|
      result = child.dfs(target)
      return result if result != nil
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      node = queue.first

      return node if node.value == target
      node.children.each do |child|
        queue << child
      end

      queue.shift
    end
    nil
  end


  def inspect
    "{#{self.value}}" #position only
    # "{#{self.value}, #{self.children}}" #position and children
  end

end
