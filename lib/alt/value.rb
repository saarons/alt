# encoding: UTF-8

class Alt::Value  
  def self.alt
    @alt ||= {}
  end
  
  def [](name, *args)    
    val = self.class.alt[name]
    if name == "()"
      self.call(args)
    else
      case val
      when Alt::EmbeddedFunction
        val.curry(self)
      else
        val
      end
    end
  end
  
  def self.embedded_function(name, pure = true, &block)
    alt[name] = Alt::EmbeddedFunction.new(pure, block)
  end
  
  def to_boolean
    case self
    when Alt::False, Alt::Nil
      false
    else
      true
    end
  end
end

require "alt/embedded_function"