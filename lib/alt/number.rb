# encoding: UTF-8

require "alt/value"

class Alt::Number < Alt::Value
	include Comparable
	attr_reader :value

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
	
	method("sqrt") do |receiver|
		Math.sqrt(receiver.value.to_f).to_r
	end
	
	method("sin") do |receiver|
		Math.sin(receiver.value.to_f).to_r
	end
	
	method("cos") do |receiver|
		Math.cos(receiver.value.to_f).to_r
	end
	
	method("tan") do |receiver|
		Math.tan(receiver.value.to_f).to_r
	end
	
	method("log10") do |receiver|
		Math.log10(receiver.value.to_f).to_r
	end
	
	method("log2") do |receiver|
		Math.log2(receiver.value.to_f).to_r
	end

	method("abs") do |receiver|
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
