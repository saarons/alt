# encoding: UTF-8

require "alt/value"
require "alt/booleans"

class Alt::Function < Alt::Value
  attr_reader :arguments
  
  def initialize(arguments, expressions, pure, context)
    @pure = pure
    @context = context
    @arguments = arguments
    @expressions = expressions
  end
  
  class << self
    def name
      "function"
    end
  end

  def call(context, *arguments)
    context.check_purity!(@pure)
    new_context = Alt::Context.new(@context, @pure)
    
    new_context["self"] = self
    new_context["arguments"] = arguments

    if @arguments
      @arguments.each_with_index do |param, index|
        new_context[param] = arguments[index] || Alt::Nil.instance
      end
    end
    
    catch :return do
      @expressions.eval(new_context)
    end
  end
  
  attribute("arity") do |receiver|
    receiver.arguments.count.to_alt
  end
  
  attribute("arguments") do |receiver|
    receiver.arguments.to_alt
  end
  
  def inspect
    "(#{@arguments.try(:join, ", ")})#{"!" unless @pure} { ... }"
  end
end