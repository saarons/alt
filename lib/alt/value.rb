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
      when Alt::Method
        val.curry(self)
      when nil
        raise(Alt::UndefinedValue, [self, name])
      else
        val
      end
    end
  end
  
  def self.method(name, pure = true, &block)
    require "alt/method"
    alt[name] = Alt::Method.new(name, pure, block)
  end
  
  def to_boolean
    case self
    when Alt::False, Alt::Nil
      false
    else
      true
    end
  end
  
  def self.from(object)
    case object
    when ::String
      Alt::String.new(object)
    when Hash
      Alt::Object.new(object.reduce({}) { |memo, (k, v)| memo.merge(k.to_s => from(v)) })
    when Array
      Alt::Array.new(object.map { |o| from(o) })
    end
  end
  
  private
  def lookup(name)
    klass = self.class
    superklass = klass.superclass
    klass.alt[name] || (superklass.respond_to?(:alt) ? superklass.alt[name] : nil)
  end
end