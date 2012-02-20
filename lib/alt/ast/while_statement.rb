# encoding: UTF-8

require "alt/booleans"

class Alt::AST::WhileStatement
  def eval(context)
    context.give_me_a_break do |context|
      catch :break do
        while @value.eval(context).to_boolean
          @block.eval(context)
        end
      end
    end
    Alt::Nil.instance
  end
end