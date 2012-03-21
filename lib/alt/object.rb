# encoding: UTF-8

require "alt/value"

class Alt::Object < Alt::Value
  attr_reader :value
  
  def initialize(object = {})
    @value = object
  end
  
  method("equals") do |receiver, argument|
    s1 = receiver.value
    s2 = argument.value
    (s1 == s2).to_alt
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
    value = argument2.value
    if s.has_key?(field)
      s[field] = value
    else
      "The field given does not exist."
    end
  end
  
  method("remove") do |receiver, argument|
    @s1 = receiver.value
    s2 = argument.value
    @s1.delete(s2)
  end
  
  method("size") do |receiver|
    s = receiver.value
    s.size()
  end
  
  method("values") do |receiver|
    s = receiver.value
    s.values
  end
    
  def inspect
    "{#{@value.map { |k, v| k.inspect + ": " + v.inspect }.join(", ")}}"
  end
end