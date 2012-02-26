# encoding: UTF-8

require "alt/booleans"

class TrueClass  
  def to_alt
    Alt::True.instance
  end
end
