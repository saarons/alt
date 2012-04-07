# encoding: UTF-8

require "alt/value"

class Alt::Number < Alt::Value
  include Comparable
  attr_reader :value
  
  def initialize(value)
    @value = Rational(value)
  end
  
  ["+", "-", "*", "/"].each do |operator|
    method(operator) do |receiver, argument|
      receiver.value.send(operator, argument.value)
    end
  end
  
  method("^") do |receiver, argument|
    receiver.value ** argument.value
  end

  ["<", "<=", ">", ">=", "==", "!=", "<=>"].each do |symbol|
    method(symbol) do |receiver, argument|
      receiver.send(symbol, argument)
    end
  end
  
  method("abs") do |receiver|
    receiver.value.abs
  end

  method("绝对值") do |receiver|
    receiver.value.abs
  end
  method("floor") do |receiver|
    receiver.value.floor
  end
  method("ceil") do |receiver|
	  receiver.value.ceil
  end
  method("denominator") do |receiver|
	  receiver.value.denominator
  end

method("round") do |receiver|
	receiver.value.round
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
