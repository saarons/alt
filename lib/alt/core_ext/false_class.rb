# encoding: UTF-8

require "alt/booleans"

class FalseClass
  def to_alt
    Alt::False.instance
  end
end
