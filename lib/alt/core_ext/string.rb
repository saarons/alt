# encoding: UTF-8

require "alt/string"

class String
  def eval(context)
    context[self]
  end
  
  def to_alt
    Alt::String.new(self)
  end
end