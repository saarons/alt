# encoding: UTF-8

class Alt::AST::MethodCall
  def eval(context)
    arguments = @arguments.try(:map) { |arg| arg.eval(context) }
    @receiver.eval(context)[@method, *arguments]
  end
end