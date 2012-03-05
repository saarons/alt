# encoding: UTF-8

require "alt/value"

class Alt::Method < Alt::Value
  def initialize(receiver, template)
    @receiver = receiver
    @template = template
  end
  
  def call(context, *arguments)
    @template.block.call(@receiver, *arguments)
  end
  
  def inspect
    @template.inspect
  end
end

class Alt::MethodTemplate
  attr_reader :block
  
  def initialize(name, pure, block)
    @name = name
    @pure = pure
    @block = block
  end
  
  def supply(receiver)
    Alt::Method.new(receiver, self)
  end
  
  def inspect
    "#{"! " unless @pure}{ #{@name} }"
  end
end