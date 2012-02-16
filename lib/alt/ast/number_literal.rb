# encoding: UTF-8

require "alt/string"

class Alt::AST::NumberLiteral
  def eval
    Alt::String.new(@number)["to_i"]
  end
end