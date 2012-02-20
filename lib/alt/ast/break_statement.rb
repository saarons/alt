# encoding: UTF-8

class Alt::AST::BreakStatement
  def eval(context)
    context.expect_break ? (throw :break) : Alt::Nil.instance
  end
end