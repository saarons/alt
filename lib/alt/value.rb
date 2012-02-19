# encoding: UTF-8

class Alt::Value  
  def self.alt
    @alt ||= {}
  end
  
  def [](name, *args)
    val = self.class.alt[name]
    case val
    when Proc
      proc { |method, *args| val.call(self, *args) }
    else
      val
    end
  end
end