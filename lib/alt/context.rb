# encoding: UTF-8

class Alt::Context  
  def initialize(parent = nil, pure = false)
    @pure = pure
    @locals = {}
    @parent = parent
  end
  
  def [](name)
    @locals[name] || @parent.try(:[], name) || raise(Alt::UndefinedVariable, name)
  end
  
  def []=(name, value)
    if @locals[name]
      raise Alt::VariableReassignment, name
    else
      @locals[name] = value
    end
  end
end