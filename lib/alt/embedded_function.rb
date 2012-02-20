# encoding: UTF-8

require "alt/value"

class Alt::EmbeddedFunction < Alt::Value
  attr_reader :pure
  
  def initialize(pure, block)
    @pure = pure
    @block = block
  end
  
  def call(arguments)
    @block[arguments]
  end
  
  def curry(receiver)
    Alt::EmbeddedFunction.new(@pure, @block.curry[receiver])
  end
end