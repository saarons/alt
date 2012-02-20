# encoding: UTF-8

require "alt/booleans"

class Alt::AST::WhileStatement
  def eval(context)
    catch :break do
      while @value.eval(context).to_boolean
        @block.eval(context)
      end
    end
    Alt::Nil.instance
  end
end