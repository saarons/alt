# encoding: UTF-8

require "alt/value"
require "bigdecimal"

class Alt::Number < Alt::Value
  attr_reader :value
  
  def initialize(string)
    @value = BigDecimal.new(string)
  end
  
  alt["+"] = proc do |receiver, *arguments|
    Alt::Number.new(receiver.value + arguments.first.value)
  end

  alt["-"] = proc do |receiver, *arguments|
    Alt::Number.new(receiver.value - arguments.first.value)
  end

  alt["*"] = proc do |receiver, *arguments|
    Alt::Number.new(receiver.value * arguments.first.value)
  end

  alt["/"] = proc do |receiver, *arguments|
    Alt::Number.new(receiver.value / arguments.first.value)
  end
  
  def inspect
    @value.to_s("F")
  end
end