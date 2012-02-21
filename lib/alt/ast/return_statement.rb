# encoding: UTF-8

class Alt::AST::ReturnStatement
  def eval(context)
    throw :return, (@value.try(:eval, context) || Alt::Nil.instance)
  end
end