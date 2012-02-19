# encoding: UTF-8

class Alt::AST::MethodCall
  def eval(context)
    @receiver.eval(context)[@method, @arguments.try(:map) { |arg| arg.eval(context) }]
  end
end