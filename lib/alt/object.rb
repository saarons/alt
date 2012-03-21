# encoding: UTF-8

require "alt/value"

class Alt::Object < Alt::Value
  attr_reader :value
  
  def initialize(object = {})
    @value = object
  end
  
  method("==") do |receiver, argument|
    receiver.value == argument.value
  end
  
  method("fields") do |receiver|
    s = receiver.value
    s.keys
  end
  
  method("hasField") do |receiver, argument|
    @s = receiver.value
    field = argument.value
    if @s.has_key?(field)
      true
    else
      false
    end
  end
  
  method("put") do |receiver, argument1, argument2|
    s = receiver.value
    field = argument1.value
    if s.has_key?(field)
      s[field] = argument2
    else
      "The field given does not exist."
    end
  end
  
  method("remove") do |receiver, argument|
    @s1 = receiver.value
    s2 = argument.value
    @s1.delete(s2)
  end
  
  attribute("size") do |receiver|
    receiver.value.size
  end
  
  attribute("values") do |receiver|
    receiver.value.values
  end
    
  def inspect
    "{#{@value.map { |k, v| k.inspect + ": " + v.inspect }.join(", ")}}"
  end
end