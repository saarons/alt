# encoding: UTF-8

require "alt/number"

class Integer
  def to_alt
    Alt::Number.new(self)
  end
end