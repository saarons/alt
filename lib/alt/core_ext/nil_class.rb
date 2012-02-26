# encoding: UTF-8

require "alt/booleans"

class NilClass
  def try(*args)
    nil
  end
  
  def to_alt
    Alt::Nil.instance
  end
end
