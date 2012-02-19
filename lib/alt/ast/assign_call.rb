# encoding: UTF-8

class Alt::AST::AssignCall
  def eval(context)
    context[@identifier] = @value.eval(context)
  end
end