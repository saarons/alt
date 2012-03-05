# encoding: UTF-8

require "alt/value"

class Alt::Object < Alt::Value
  def initialize(object = {})
    @value = object
  end
  
  def inspect
    "{#{@value.map { |k, v| k.inspect + ": " + v.inspect }.join(", ")}}"
  end
end