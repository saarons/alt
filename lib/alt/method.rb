# encoding: UTF-8

require "alt/value"

class Alt::Method < Alt::Value
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
    Alt::Method.new(@name, @pure, @block.curry[receiver])
  end
  
  def inspect
    "#{"! " unless @pure}{ #{@name} }"
  end
end