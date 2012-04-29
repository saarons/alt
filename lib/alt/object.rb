# encoding: UTF-8

require "alt/value"

class Alt::Object < Alt::Value  
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
    receiver.value[argument1] = argument2
  end
  
  method("remove") do |receiver, argument|
    receiver.value.delete(argument)
  end
  
  method("size") do |receiver|
    receiver.value.size
  end
  
  method("fields") do |receiver|
    receiver.value.keys
  end
  
  method("values") do |receiver|
    receiver.value.values
  end
  
  attribute("method_missing") do |receiver, name, *arguments|
    field = Alt::String.new(name)
    if receiver.value.keys.include?(field)
      receiver.value[field]
    else
      puts "Field \"" + name + "\" does not exist."
      # raise(Alt::UndefinedValue, [receiver, name]) # If the attribute is not there
    end
  end
    
  def inspect
    "{#{@value.map { |k, v| k.inspect + ": " + v.inspect }.join(", ")}}"
  end
end