# encoding: UTF-8

class Alt::AST::MethodCall
  def eval(context)
    arguments = @arguments.try(:map) { |arg| arg.eval(context) }
    receiver = @receiver.eval(context)
    case @method
    when "()"
      receiver.call(context, *arguments)
    else
      receiver[@method, *arguments]
    end
  end
end