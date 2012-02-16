# encoding: UTF-8

require "alt/value"
require "bigdecimal"

class Alt::Number < Alt::Value
  def initialize(string)
    @value = BigDecimal.new(string)
  end 
end