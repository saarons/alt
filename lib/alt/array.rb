# encoding: UTF-8

require "alt/value"

class Alt::Array < Alt::Value
  def initialize(array)
    @value = array
  end
end