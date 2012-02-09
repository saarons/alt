module Alt  
  class Operator
    attr_accessor :precedence, :associativity
    
    def initialize(precedence, associativity)
      @precedence = precedence
      @associativity = associativity
    end
    
    def left_associative?
      @associativity == :left
    end
  end
  
  module PrecedenceTable  
    def self.lookup(operator)
      @operators[operator]
    end
  
    def self.op(associativity, *operators)
      @precedence ||= 0
      @operators ||= {}
      operators.each do |operator|
        @operators[operator] = Operator.new(@precedence, associativity)
      end
      @precedence += 1
    end
  
    # operator precedence, low to high
    op :left, '||'
    op :left, '&&'
    op :none, '==', '!='
    op :left, '<', '<=', '>', '>='
    op :left, '+', '-'
    op :left, '*', '/'
    op :right, '^'
  end
end