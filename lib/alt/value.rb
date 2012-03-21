# encoding: UTF-8

class Alt::Value
  require "alt/method"
  
  def self.alt
    @alt ||= {}
  end
  
  def [](name, *args)    
    val = self.class.lookup(name)
    case val
    when Alt::MethodTemplate
      val.supply(self)
    when nil
      raise(Alt::UndefinedValue, [self, name])
    when Proc
      val.curry[self].to_alt
    else
      val
    end
  end
  
  def self.method(name, pure = true, &block)
    alt[name] = Alt::MethodTemplate.new(name, pure, block)
  end
  
  def self.attribute(name, &block)
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
  
  def call(context, *arguments)
    raise(Alt::UndefinedValue, [self, "()"])
  end
  
  def to_alt
    self
  end
  
  private
  def self.lookup(name)
    alt[name] || (superclass.respond_to?(:lookup) ? superclass.lookup(name) : nil)
  end
end