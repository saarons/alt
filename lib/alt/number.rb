# encoding: UTF-8

require "alt/value"

class Alt::Number < Alt::Value
	include Comparable

	def initialize(value)
		@value = Rational(value)
	end
	
  class << self
    def name
      "number"
    end
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
	
	["sqrt", "sin", "cos", "tan", "log10", "log2"].each do |operation|
	  method(operation) do |receiver|
  		Math.send(operation, receiver.value)
  	end
	end
	
	["abs", "floor", "ceil", "numerator", "denominator", "round"].each do |unary|
	  method(unary) do |receiver|
  		receiver.value.send(unary)
  	end
	end

	method("showfloat") do |receiver|
		receiver.value.to_f.to_s
	end

	method("to_s") do |receiver|
		receiver.inspect
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
