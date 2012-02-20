# encoding: UTF-8

require "alt/value"

class Alt::Number < Alt::Value
  attr_reader :value
  
  def initialize(value)
    @value = Rational(value)
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
  
  alt["^"] = proc do |receiver, *arguments|
    Alt::Number.new(receiver.value ** arguments.first.value)
  end
  
  def inspect
    if @value.denominator == 1
      @value.numerator.to_s
    else
      "#{@value.numerator}/#{@value.denominator}"
    end
  end
end