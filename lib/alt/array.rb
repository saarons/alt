# encoding: UTF-8

require "alt/value"

class Alt::Array < Alt::Value
  attr_reader :value
  
  def initialize(array = [])
    @value = array
  end
  
  method("concat") do |receiver, argument|
    s1 = receiver.value
    s2 = argument.value
    s1.concat(s2)
  end
  
  method("equals") do |receiver, argument|
    s1 = receiver.value
    s2 = argument.value
    (s1 == s2).to_alt
  end
  
  method("pop") do |receiver|
    s = receiver.value
    if not s.empty?
      s.pop()
    else
      "The array is empty."
    end
  end
  
  method("push") do |receiver, argument|
    arr = receiver.value
    arr.push(argument)
  end
  
  method("size") do |receiver|
    s = receiver.value
    s.size()
  end
  
  def inspect
    "[" + @value.map(&:inspect).join(", ") + "]"
  end
  
  attribute("length") do |receiver|
    receiver.value.length.to_alt
  end
end