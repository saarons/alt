# encoding: UTF-8

require "alt/array"

class Alt::AST::ArrayLiteral
  def eval(context)
    Alt::Array.new(@array.map { |e| e.eval(context) })
  end
end