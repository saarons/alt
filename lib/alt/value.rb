# encoding: UTF-8

class Alt::Value  
  def self.alt
    @alt ||= {}
  end
  
  def [](name, *args)
    case val = self.class.alt[name]
    when Proc
      val.call(self, *args)
    else
      val
    end
  end
end