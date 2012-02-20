# encoding: UTF-8

require "singleton"
require "alt/value"

class Alt::True < Alt::Value
  include Singleton
  
  def inspect
    "true"
  end
end

class Alt::False < Alt::Value
  include Singleton
  
  def inspect
    "false"
  end
end

class Alt::Nil < Alt::Value
  include Singleton
  
  def inspect
    "nil"
  end
end