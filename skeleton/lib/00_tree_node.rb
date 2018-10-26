require 'byebug'

class PolyTreeNode

  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent_node)
      old_parent = self.parent
      new_parent = parent_node

      if new_parent.nil?
        old_parent.children.delete(self)
      elsif new_parent.children.include?(self) == false
        old_parent.children.delete(self) unless old_parent.nil?
        new_parent.children << self
      end

      @parent = new_parent
  end

end
