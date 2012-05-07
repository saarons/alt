# encoding: UTF-8

require "alt/core_ext/hash"
require "alt/core_ext/float"
require "alt/core_ext/string"
require "alt/embedded_function"

class Alt::Context
  attr_reader :expect_break
  
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
    @locals[name] = value
  end
  
  def catch_break
    @expect_break = true
    yield self
    @expect_break = false
  end
  
  def check_purity!(input)
    raise Alt::ImpureFunctionCalled if @pure && !input
  end
  
  DEFAULT = Alt::Context.new.tap do |c|
    c["print"] = Alt::EmbeddedFunction.create(["object"]) do |context, argument|
      puts argument.value
      Alt::Nil.instance
    end
    
    c["puts"] = Alt::EmbeddedFunction.create(["object"]) do |context, argument|
      print argument.value
      Alt::Nil.instance
    end
    
    c["Math"] = {"PI" => Math::PI}.to_alt
    
  end
end