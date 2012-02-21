# encoding: UTF-8

require "pp"
require "readline"
require "alt/runtime"

class Alt::Runtime::REPL < Alt::Runtime
  def handle_return_value(value)
    pp value if value
  end
  
  def handle_error(e)
    puts "ERROR: #{e}"
  end
  
  def setup
    puts "alt #{Alt::VERSION}"
  end
  
  def run
    while line = Readline::readline(">> ", true)
      yield line
    end
  end
  
  def evaluate(line)
    interpreter.eval(line)
  end
end