module Alt
  module AST
    class Operator
      attr_accessor :symbol, :precedence, :associativity

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
          MethodCall.new(lhs, rhs.method, rhs.arguments)
        when "[]", "()"
          MethodCall.new(lhs, @symbol, rhs.arguments)
        else
          MethodCall.new(lhs, @symbol, rhs)
        end
      end
    end
  end
end