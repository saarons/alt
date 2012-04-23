# encoding: UTF-8

class Alt::Value
  require "alt/method"
  attr_reader :value
  
  def self.alt
    @alt ||= {}
  end
  
  def [](name, *args)    
    val = self.class.lookup(name)
    case val
    when Alt::MethodTemplate
      val.supply(self)
    when nil
      self["method_missing", name, *args]
    when Proc
      val.curry[self, *args].to_alt
    else
      val
    end
  end
  
  def self.method(name, pure = true, &block)
    require "alt/grammar"
    
    if aliased_method = Alt::Grammar.method(self.name, name)
      name = aliased_method
    end
    
    alt[name] = Alt::MethodTemplate.new(name, pure, block)
  end
  
  def self.attribute(name, &block)
    if aliased_attribute = Alt::Grammar.attribute(self.name, name)
      name = aliased_attribute
    end
    
    alt[name] = block
  end
  
  def to_boolean
    case self
    when Alt::False, Alt::Nil
      false
    else
      true
    end
  end
  
  method("send") do |receiver, *arguments|
    receiver[arguments.pop.value]
  end
  
  attribute("method_missing") do |receiver, name, *arguments|
    raise(Alt::UndefinedValue, [receiver, name])
  end
  
  def call(context, *arguments)
    raise(Alt::UndefinedValue, [self, "()"])
  end
  
  def to_alt
    self
  end
  
  def eql?(other)
	  @value.eql?(other.value)
	end

  def hash
    @value.hash
  end
  
  private
  def self.lookup(name)
    alt[name] || (superclass.respond_to?(:lookup) ? superclass.lookup(name) : nil)
  end
end