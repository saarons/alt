# encoding: UTF-8

class Alt::Value  
  def self.alt
    @alt ||= {}
  end
  
  def [](name, *args)
    val = self.class.alt[name]
    case val
    when Proc
      val.lambda? ? proc { |method, *args| val.call(self, *args) } : val.call(self, *args)
    else
      val
    end
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