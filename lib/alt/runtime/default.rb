# encoding: UTF-8

require "alt/number"
require "alt/runtime"
require "alt/function"

class Alt::Runtime::Default < Alt::Runtime
  def run
    yield Alt.ast(File.read(@options[:file]))
  end
  
  def cleanup(return_value)
    case return_value
    when Alt::Number
      exit(return_value.value.to_i)
    else
      exit
    end
  end
  
  def evaluate(ast)
    main_function = Alt::Function.new(["arguments", "environment"], ast, false, context)
    main_function.call([@options[:args].to_alt, @options[:env].to_hash.to_alt])
  end
end