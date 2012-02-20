# encoding: UTF-8

class Alt::AST::AndOperator
  def eval(context)    
    if (lhs = @lhs.eval(context)).to_boolean && (rhs = @rhs.eval(context)).to_boolean
      rhs
    else
      lhs
    end
  end
end