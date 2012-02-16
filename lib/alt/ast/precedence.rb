# encoding: UTF-8

require "alt/ast/operator"

module Alt::AST::PrecedenceTable  
  def self.lookup(operator)
    @operators[operator]
  end

  def self.op(associativity, *operators)
    @precedence ||= 0
    @operators ||= {}
    operators.each do |operator|
      @operators[operator] = Alt::AST::Operator.new(operator, @precedence, associativity)
    end
    @precedence += 1
  end

  # operator precedence, low to high
  op :right, '=', '＝'
  op :left, '||'
  op :left, '&&'
  op :none, '==', '!='
  op :left, '<', '<=', '>', '>='
  op :left, '<<', '>>'
  op :left, '+', '-'
  op :left, '*', '/'
  op :right, '^'
  op :left, '.', "[]", "()"
end