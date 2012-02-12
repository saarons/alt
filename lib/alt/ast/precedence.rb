module Alt
  module AST
    module PrecedenceTable  
      def self.lookup(operator)
        @operators[operator]
      end
    
      def self.op(associativity, *operators)
        @precedence ||= 0
        @operators ||= {}
        operators.each do |operator|
          @operators[operator] = AST::Operator.new(operator, @precedence, associativity)
        end
        @precedence += 1
      end
    
      # operator precedence, low to high
      op :right, '='
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
  end
end