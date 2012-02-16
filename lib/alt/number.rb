require "bigdecimal"

module Alt
  class Number < Value
    def initialize(string)
      @value = BigDecimal.new(string)
    end 
  end
end