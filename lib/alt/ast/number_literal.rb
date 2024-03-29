# encoding: UTF-8

require "alt/string"

class Alt::AST::NumberLiteral
  def eval(context)
    Alt::String.new(@number)["to_n"].call(context)
  end
end