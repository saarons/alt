# encoding: UTF-8

class String
  def eval(context)
    context[self] || raise(Alt::UndefinedVariable, self)
  end
end