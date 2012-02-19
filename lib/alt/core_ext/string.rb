# encoding: UTF-8

class String
  def eval(context)
    context[self]
  end
end