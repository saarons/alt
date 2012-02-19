# encoding: UTF-8

class Alt::AST::ReturnStatement
  def eval(context)
    throw :return, @value.eval(context)
  end
end