# encoding: UTF-8

require "alt/booleans"

class Alt::AST::TrueLiteral
  def eval(context)
    Alt::True.instance
  end
end