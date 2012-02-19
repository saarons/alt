# encoding: UTF-8

class Alt::Context
  attr_reader :locals, :pure
  
  def initialize(parent = nil, pure = false)
    @pure = pure
    @locals = {}
    @parent = parent
  end
  
  def [](name)
    @locals[name] || @parent.try(:[], name)
  end
  
  def []=(name, value)
    @locals[name] = value
  end
end