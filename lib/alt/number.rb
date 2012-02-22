# encoding: UTF-8

require "alt/value"

class Alt::Number < Alt::Value
  include Comparable
  attr_reader :value
  
  def initialize(value)
    @value = Rational(value)
  end
  
  method("+") do |receiver, arguments|
    Alt::Number.new(receiver.value + arguments.first.value)
  end

  method("-") do |receiver, arguments|
    Alt::Number.new(receiver.value - arguments.first.value)
  end

  method("*") do |receiver, arguments|
    Alt::Number.new(receiver.value * arguments.first.value)
  end

  method("/") do |receiver, arguments|
    Alt::Number.new(receiver.value / arguments.first.value)
  end
  
  method("^") do |receiver, arguments|
    Alt::Number.new(receiver.value ** arguments.first.value)
  end
  
  method("<") do |receiver, arguments|
    (receiver < arguments.first) ? Alt::True.instance : Alt::False.instance
  end
  
  method("abs") do |receiver, arguments|
    Alt::Number.new(receiver.value.abs)
  end
  
  def <=>(other)
    @value <=> other.value
  end
  
  def inspect
    if @value.denominator == 1
      @value.numerator.to_s
    else
      "#{@value.numerator}/#{@value.denominator}"
    end
  end
end