# encoding: UTF-8

class Alt::AST::BreakStatement
  def eval(context)
    context.expect_break ? (throw :break) : raise(Alt::UnexpectedBreak)
  end
end