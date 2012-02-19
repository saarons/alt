# encoding: UTF-8

require "alt/string"

class Alt::AST::StringLiteral
  def eval(context)
    Alt::String.new(@string)
  end
end