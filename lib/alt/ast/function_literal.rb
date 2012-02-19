# encoding: UTF-8

require "alt/function"

class Alt::AST::FunctionLiteral
  def eval(context)
    Alt::Function.new(@arguments, @expressions, @pure, context)
  end
end