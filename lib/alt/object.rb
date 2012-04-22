# encoding: UTF-8

require "alt/value"

class Alt::Object < Alt::Value
  attr_reader :value
  
  def initialize(object = {})
    @value = object
  end
  
  class << self
    def name
      "object"
    end
  end
  
  method("==") do |receiver, argument|
    receiver.value == argument.value
  end
  
  method("has_field") do |receiver, argument|
    receiver.value.keys.include?(argument)
  end
  
  method("put") do |receiver, argument1, argument2|
    if receiver.value.keys.include?(argument1)
      receiver.value[argument1] = argument2
    else
      "The field given does not exist."
    end
  end
  
  method("remove") do |receiver, argument|
    receiver.value.delete(argument)
  end
  
  attribute("size") do |receiver|
    receiver.value.size
  end
  
  attribute("fields") do |receiver|
    receiver.value.keys
  end
  
  attribute("values") do |receiver|
    receiver.value.values
  end
  
  attribute("method_missing") do |receiver, name, *arguments|
    raise(Alt::UndefinedValue, [receiver, name]) # If the attribute is not there
  end
    
  def inspect
    "{#{@value.map { |k, v| k.inspect + ": " + v.inspect }.join(", ")}}"
  end
end