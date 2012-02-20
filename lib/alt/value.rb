# encoding: UTF-8

class Alt::Value  
  def self.alt
    @alt ||= {}
  end
  
  def [](name, *args)    
    val = lookup(name)
    if name == "()"
      self.call(args)
    else
      case val
      when Alt::EmbeddedFunction
        val.curry(self)
      when nil
        raise(Alt::UndefinedValue, [self, name])
      else
        val
      end
    end
  end
  
  def self.embedded_function(name, pure = true, &block)
    require "alt/embedded_function"
    alt[name] = Alt::EmbeddedFunction.new(name, pure, block)
  end
  
  def to_boolean
    case self
    when Alt::False, Alt::Nil
      false
    else
      true
    end
  end
  
  embedded_function("&&") do |receiver, arguments|
    if receiver.to_boolean && arguments.first.to_boolean
      arguments.first
    else
      receiver
    end
  end
  
  embedded_function("||") do |receiver, arguments|
    arguments.unshift(receiver).find(proc { arguments.last }) { |x| x.to_boolean }
  end
  
  private
  def lookup(name)
    klass = self.class
    superklass = klass.superclass
    klass.alt[name] || (superklass.respond_to?(:alt) ? superklass.alt[name] : nil)
  end
end