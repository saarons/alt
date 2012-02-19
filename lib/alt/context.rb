# encoding: UTF-8

class Alt::Context
  attr_reader :locals
  
  def initialize(parent = nil)
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