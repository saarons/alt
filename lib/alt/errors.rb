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