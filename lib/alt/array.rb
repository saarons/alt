# encoding: UTF-8

require "alt/value"

class Alt::Array < Alt::Value
  attr_reader :value
  
  def initialize(array = [])
    @value = array
  end
  
  def inspect
    "[" + @value.map(&:inspect).join(", ") + "]"
  end
  
  attribute("length") do |receiver|
    receiver.value.length.to_alt
  end
end