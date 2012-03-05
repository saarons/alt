# encoding: UTF-8

class Alt::Value  
  def self.alt
    @alt ||= {}
  end
  
  def [](name, *args)    
    val = lookup(name)
    case val
    when Alt::MethodTemplate
      val.supply(self)
    when nil
      raise(Alt::UndefinedValue, [self, name])
    when Proc
      val.curry[self]
    else
      val
    end
  end
  
  def self.method(name, pure = true, &block)
    require "alt/method"
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
  def lookup(name)
    klass = self.class
    superklass = klass.superclass
    klass.alt[name] || (superklass.respond_to?(:alt) ? superklass.alt[name] : nil)
  end
end