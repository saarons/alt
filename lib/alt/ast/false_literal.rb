# encoding: UTF-8

require "alt/booleans"

class Alt::AST::FalseLiteral
  def eval(context)
    Alt::False.instance
  end
end