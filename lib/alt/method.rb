# encoding: UTF-8

class Alt::Method < Alt::Value
  def initialize(receiver, template)
    @receiver = receiver
    @template = template
  end
  
  def call(context, *arguments)
    context.check_purity!(@template.pure)
    @template.block.call(@receiver, *arguments).to_alt
  end
  
  def inspect
    @template.inspect
  end
end

class Alt::MethodTemplate
  attr_reader :block, :pure
  
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