# encoding: UTF-8

require "alt/string"

class Alt::AST::StringLiteral
  def eval
    Alt::String.new(@string)
  end
end