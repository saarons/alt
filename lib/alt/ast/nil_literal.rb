# encoding: UTF-8

require "alt/booleans"

class Alt::AST::NilLiteral
  def eval(context)
    Alt::Nil.instance
  end
end