# encoding: UTF-8

require "alt/number"

class Float
  def to_alt
    Alt::Number.new(self)
  end
end