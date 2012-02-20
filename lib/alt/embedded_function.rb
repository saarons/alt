# encoding: UTF-8

require "alt/value"

class Alt::EmbeddedFunction < Alt::Value
  attr_reader :pure
  
  def initialize(name, pure, block)
    @name = name
    @pure = pure
    @block = block
  end
  
  def call(arguments)
    @block[arguments]
  end
  
  def curry(receiver)
    Alt::EmbeddedFunction.new(@name, @pure, @block.curry[receiver])
  end
  
  def inspect
    "##{@name} (...)#{"!" unless @pure} { ... }"
  end
end