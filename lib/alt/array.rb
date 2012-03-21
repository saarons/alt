# encoding: UTF-8

require "alt/value"

class Alt::Array < Alt::Value
  attr_reader :value
  
  def initialize(array = [])
    @value = array
  end
  
  method("concat") do |receiver, argument|
    receiver.value.dup.concat(argument.value)
  end
  
  method("==") do |receiver, argument|
    receiver.value == argument.value
  end
  
  ["push", "<<"].each do |x|
    method(x) do |receiver, argument|
      receiver.value.dup.push(argument)
    end
  end
  
  attribute("length") do |receiver|
    receiver.value.length
  end
  
  def inspect
    "[" + @value.map(&:inspect).join(", ") + "]"
  end
end