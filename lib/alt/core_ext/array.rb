# encoding: UTF-8

require "alt/booleans"

class Array
  def eval(context)
    return_value = nil
    self.each do |node|
      return_value = node.eval(context)
    end
    return_value || Alt::Nil.instance
  end
end