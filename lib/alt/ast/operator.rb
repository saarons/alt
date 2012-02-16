# encoding: UTF-8

class Alt::AST::Operator
  attr_reader :symbol, :precedence, :associativity

  def initialize(symbol, precedence, associativity)
    @symbol = symbol
    @precedence = precedence
    @associativity = associativity
  end

  def left_associative?
    @associativity == :left
  end
  
  def apply(lhs, rhs)
    case @symbol
    when "."
      Alt::AST::MethodCall.new(lhs, rhs.method, rhs.arguments)
    when "[]", "()"
      Alt::AST::MethodCall.new(lhs, @symbol, rhs.arguments)
    else
      Alt::AST::MethodCall.new(lhs, @symbol, rhs)
    end
  end
end
