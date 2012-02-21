# encoding: UTF-8

require "alt/array"
require "alt/object"
require "alt/runtime"
require "alt/function"

class Alt::Runtime::Default < Alt::Runtime
  def run
    yield Alt.ast(File.read(@options[:file]))
  end
  
  def cleanup(return_value)
    exit(return_value.try(:value).try(:to_i) || true)
  end
  
  def evaluate(ast)
    main_function = Alt::Function.new(["arguments", "environment"], ast, false, context)
    main_function.call([Alt::Value.from(@options[:args]), Alt::Value.from(@options[:env].to_hash)])
  end
end