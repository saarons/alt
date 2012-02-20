# encoding: UTF-8

class Alt::AST::OrOperator
  def eval(context)
    (lhs = @lhs.eval(context)).to_boolean ? lhs : @rhs.eval(context)
  end
end