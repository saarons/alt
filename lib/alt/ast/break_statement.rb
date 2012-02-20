# encoding: UTF-8

class Alt::AST::BreakStatement
  def eval(context)
    throw :break if context.catch_break
  end
end