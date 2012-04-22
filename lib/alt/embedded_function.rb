# encoding: UTF-8

require "alt/function"

class Alt::EmbeddedFunction < Alt::Function
  def call(context, *arguments)
    context.check_purity!(@pure)
    @expressions.call(context, *arguments)
  end
  
  class << self
    def name
      "embedded_function"
    end
  end
  
  def self.create(arguments, pure = true, &block)
    Alt::EmbeddedFunction.new(arguments, block, pure, nil)
  end
end