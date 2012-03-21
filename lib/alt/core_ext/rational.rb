# encoding: UTF-8

require "alt/number"

class Rational
  def to_alt
    Alt::Number.new(self)
  end
end