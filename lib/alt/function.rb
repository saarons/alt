# encoding: UTF-8

require "alt/value"
require "alt/context"
require "alt/booleans"

class Alt::Function < Alt::Value
  attr_reader :arguments, :expressions, :pure, :context

  def initialize(arguments, expressions, pure, context)
    @pure = pure
    @context = context
    @arguments = arguments
    @expressions = expressions
  end

  alt["()"] = proc do |receiver, *arguments|
    context = Alt::Context.new(receiver.context, receiver.pure)

    receiver.arguments.each_with_index do |param, index|
      context.locals[param] = arguments[index] || Alt::Nil.instance
    end

    receiver.expressions.eval(context)
  end
end