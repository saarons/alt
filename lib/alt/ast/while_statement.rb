# encoding: UTF-8

require "alt/booleans"

class Alt::AST::WhileStatement
  def eval(context)
    context.catch_break = true
    catch :break do
      while @value.eval(context).to_boolean
        @block.eval(context)
      end
    end
    context.catch_break = false
    Alt::Nil.instance
  end
end