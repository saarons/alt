# encoding: UTF-8

class Alt::Context  
  attr_accessor :expect_break
  
  def initialize(parent = nil, pure = false)
    @pure = pure
    @locals = {}
    @parent = parent
    @expect_break = false
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
  
  def give_me_a_break
    @expect_break = true
    yield self
    @expect_break = false
  end
  
  DEFAULT = Alt::Context.new.tap do |c|
    c["print"] = proc { |context, arguments| puts arguments.inspect; Alt::Nil.instance }
  end
end