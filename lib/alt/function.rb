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

  def call(context, *arguments)
    context.check_purity!(@pure)    
    new_context = Alt::Context.new(@context, @pure)

    @arguments.each_with_index do |param, index|
      new_context[param] = arguments[index] || Alt::Nil.instance
    end
    
    catch :return do
      @expressions.eval(new_context)
    end
  end
  
  attribute("arity") do |receiver, *arguments|
    receiver.arguments.count.to_alt
  end
  
  def inspect
    "(#{@arguments.join(", ")})#{"!" unless @pure} { ... }"
  end
end