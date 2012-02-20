# encoding: UTF-8

class Alt::AST::BreakStatement
  def eval(context)
    context.catch_break ? (throw :break) : Alt::Nil.instance
  end
end