# encoding: UTF-8

class Alt::RuntimeError < StandardError
end

class Alt::UndefinedVariable < Alt::RuntimeError
  def initialize(variable)
    super
    @variable = variable
  end
  
  def to_s
    "undefined variable #{@variable}"
  end
end

class Alt::VariableReassignment < Alt::RuntimeError
  def initialize(variable)
    super
    @variable = variable
  end
  
  def to_s
    "variable '#{@variable}' can not be reassigned"
  end
end

class Alt::UndefinedValue < Alt::RuntimeError
  def initialize(rv)
    super
    @receiver, @value = rv
  end
  
  def to_s
    "'#{@receiver.inspect}' does not respond to '#{@value}'"
  end
end

class Alt::UnexpectedBreak < Alt::RuntimeError  
  def to_s
    "Unexpected break"
  end
end