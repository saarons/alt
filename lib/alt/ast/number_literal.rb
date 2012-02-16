module Alt
  module AST
    class NumberLiteral
      def eval
        Alt::String.new(@number)["to_i"]
      end
    end
  end
end