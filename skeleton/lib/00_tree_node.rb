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
end
